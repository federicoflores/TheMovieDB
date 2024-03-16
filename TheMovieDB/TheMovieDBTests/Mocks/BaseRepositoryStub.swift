//
//  BaseRepositoryStub.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation
@testable import TheMovieDB

class BaseRepositoryStub: BaseRepositoryProtocol {
    func fetchDecodable<T>(endpoint: TheMovieDB.Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        let model: Decodable = JSONLoader().topRatedMoviesResponse()
        
        completion(.success(model as! T))
    }
    
}
