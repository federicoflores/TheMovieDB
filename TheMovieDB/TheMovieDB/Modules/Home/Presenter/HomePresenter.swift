//
//  HomePresenter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

protocol HomePresenterProtocols: AnyObject {
    var topRatedMoviesResponse: TopRatedResponse { get}
    func fetchTopRatedMovies()
    func onFetchTopRatedMoviesSuccess(response: TopRatedResponse)
    func onFetchTopRatedMoviesFail(error: String)
    func numberOfRowsInSection() -> Int
    func didSelectRow(at indexPath: Int)
    func getTopRatedMovieViewModel(from row: Int) -> HomeMovieViewModel?
    func didScrollToBottom(row: Int) -> Bool
}

class HomePresenter: HomePresenterProtocols {
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
    let dateFormatter = TMDBDateFormatter()
    
    var topRatedMoviesResponse: TopRatedResponse = TopRatedResponse(results: [])
    private var currentPage = 1
    
    func fetchTopRatedMovies() {
        homeView?.showLoadingView()
        homeInteractor?.fetchTopRatedMovies(page: currentPage)
    }
    
    func onFetchTopRatedMoviesSuccess(response: TopRatedResponse) {
        homeView?.hideLoadingView()
        topRatedMoviesResponse.results.append(contentsOf: response.results)
        currentPage += 1
        homeView?.reloadTableView()
        homeView?.isEmptyStateHidden(isHidden: true)
    }
    
    func onFetchTopRatedMoviesFail(error: String) {
        homeView?.hideLoadingView()
        homeView?.isEmptyStateHidden(isHidden: false)
        homeView?.setEmptyStateSubtitle(subtitle: error)
    }
    
    func numberOfRowsInSection() -> Int {
        topRatedMoviesResponse.results.count
    }
    
    func didSelectRow(at indexPath: Int) {
        let movie = topRatedMoviesResponse.results[indexPath]
        homeRouter?.goToDetail(with: DetailMovieViewModel(
            title: movie.title,
            posterPath: Constants.imageBaseUrl + movie.posterPath,
            releaseDate: dateFormatter.formatStringDate(stringDate: movie.releaseDate, from: .yearMonthDay, to: .dayMonthYear),
            overview: movie.overview,
            rating: movie.voteAverage))
    }
    
    func getTopRatedMovieViewModel(from row: Int) -> HomeMovieViewModel? {
        let movie = topRatedMoviesResponse.results[row]
        
        
        return HomeMovieViewModel(
            title: movie.title,
            releaseDate: dateFormatter.formatStringDate(stringDate: movie.releaseDate, from: .yearMonthDay, to: .dayMonthYear),
            posterPath: movie.posterPath)
    }
    
    func didScrollToBottom(row: Int) -> Bool {
        row == (topRatedMoviesResponse.results.count) - 1
    }
}
