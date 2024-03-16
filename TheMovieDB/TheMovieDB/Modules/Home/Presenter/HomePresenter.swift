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
    
    fileprivate enum Constant {
        static let delay: CGFloat = 0.5
    }
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
    let dateFormatter = TMDBDateFormatter()
    
    var topRatedMoviesResponse: TopRatedResponse = TopRatedResponse(results: [])
    private var currentPage = 1
    
    func fetchTopRatedMovies() {
        homeView?.showLoadingView()
        DispatchQueue.main.asyncAfter(deadline: .now() + Constant.delay, execute: { [weak self] in
            guard let self = self else { return }
            self.homeInteractor?.fetchTopRatedMovies(page: self.currentPage)
        })
    }
    
    func onFetchTopRatedMoviesSuccess(response: TopRatedResponse) {
        homeView?.hideLoadingView()
        topRatedMoviesResponse.results.append(contentsOf: response.results)
        currentPage += 1
        homeView?.isEmptyStateHidden(isHidden: true)
        homeView?.insertRows(indexPath: setIndexPaths(response: response))
    }
    
    private func setIndexPaths(response: TopRatedResponse) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        let range = (topRatedMoviesResponse.results.count - response.results.count)..<topRatedMoviesResponse.results.count
        range.forEach{
            indexPaths.append(IndexPath(row: $0, section: 0))
        }
        return indexPaths
    }
    
    func onFetchTopRatedMoviesFail(error: String) {
        homeView?.hideLoadingView()
        homeView?.isEmptyStateHidden(isHidden: currentPage == 1 ? false : true)
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
