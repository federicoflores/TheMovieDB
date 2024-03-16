//
//  HomeInteractor.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

protocol HomeInteractorProtocols: AnyObject {
    var repository: BaseRepositoryProtocol { get }
    func fetchTopRatedMovies(page: Int)
}

class HomeInteractor: HomeInteractorProtocols {
    var repository: BaseRepositoryProtocol
    weak var homePresenter: HomePresenterProtocols?
    
    init(repository: BaseRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchTopRatedMovies(page: Int) {
        repository.fetchDecodable(endpoint: DataEndpoint.fetchMovieTopRated(page: "\(page)"))  { [weak self] (result: Result<TopRatedResponse, Error>) in
            switch result {
            case .success(let response):
                self?.homePresenter?.onFetchTopRatedMoviesSuccess(response: response)
            case .failure(let error):
                self?.homePresenter?.onFetchTopRatedMoviesFail(error: error.localizedDescription)
            }
        }
    }    
}
