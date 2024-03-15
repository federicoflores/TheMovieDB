//
//  MoviesRepository.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

enum DataEndpoint {
    case fetchMovieTopRated(page: String)
}

extension DataEndpoint: Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            preconditionFailure("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchMovieTopRated:
            return Constants.topRated
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .fetchMovieTopRated:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchMovieTopRated:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .fetchMovieTopRated(page: let page):
            return [URLQueryItem(name: "page", value: page)]
        }
    }
}
