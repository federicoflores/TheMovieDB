//
//  HomeInteractorMocks.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation
@testable import TheMovieDB

class HomeInteractorMocks: HomeInteractorProtocols {
    var repository: TheMovieDB.BaseRepositoryProtocol = BaseRepositoryStub()
    
    var numberOfTimesFetchTopRatedMoviesCalled: Int = 0
    
    func fetchTopRatedMovies(page: Int) {
        numberOfTimesFetchTopRatedMoviesCalled += 1
    }
    
    
}
