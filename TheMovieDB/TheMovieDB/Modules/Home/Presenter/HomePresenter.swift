//
//  HomePresenter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation
//TODO:: DELETE ONCE SOLVED IMAGE TROUBLE
import UIKit

protocol HomePresenterProtocols: AnyObject {
    var topRatedMoviesResponse: TopRatedResponse { get}
    func fetchTopRatedMovies()
    func onFetchTopRatedMoviesSuccess(response: TopRatedResponse)
    func onFetchTopRatedMoviesFail(error: String)
    func numberOfRowsInSection() -> Int
    func didSelectRow(at indexPath: Int)
    func getTopRatedMovieViewModel(from row: Int) -> HomeMovieViewModel?
}


class HomePresenter: HomePresenterProtocols {
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
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
    }
    
    func onFetchTopRatedMoviesFail(error: String) {
        homeView?.hideLoadingView()
        print(error)
    }
    
    func numberOfRowsInSection() -> Int {
        topRatedMoviesResponse.results.count
    }
    
    func didSelectRow(at indexPath: Int) {
        homeRouter?.goToDetail()
    }
    
    func getTopRatedMovieViewModel(from row: Int) -> HomeMovieViewModel? {
        let movie = topRatedMoviesResponse.results[row]
        return HomeMovieViewModel(title: movie.title, releaseDate: movie.releaseDate, posterPath: movie.posterPath)
    }
    
}
