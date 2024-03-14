//
//  HomeInteractor.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

protocol HomeInteractorProtocols: AnyObject {
    var provider: BaseRepositoryProtocol { get }
    func fetchTopRatedMovies(page: Int)
}

class HomeInteractor: HomeInteractorProtocols {
    var provider: BaseRepositoryProtocol
    weak var homePresenter: HomePresenterProtocols?
    
    init(provider: BaseRepositoryProtocol) {
        self.provider = provider
    }
    
    func fetchTopRatedMovies(page: Int) {
        BaseRepository().fetchDecodable(endpoint: DataEndpoint.fetchMovieTopRated)  { [weak self] (result: Result<TopRatedResponse, Error>) in
            switch result {
            case .success(let response):
                self?.homePresenter?.onFetchTopRatedMoviesSuccess(response: response)
            case .failure(let error):
                self?.homePresenter?.onFetchTopRatedMoviesFail(error: error.localizedDescription)
            }
        }
    }
    
    
    
    
}
