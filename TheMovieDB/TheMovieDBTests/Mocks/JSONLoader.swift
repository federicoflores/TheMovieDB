//
//  JSONLoader.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation
@testable import TheMovieDB

class JSONLoader {
    
    enum MockedResponses: String {
        case topRatedMoviesResponse = "topRatedMoviesResponse"
    }
    
    internal func topRatedMoviesResponse() -> TopRatedResponse? {
        if let path = Bundle.main.path(forResource: MockedResponses.topRatedMoviesResponse.rawValue, ofType: "json") {
        do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let item = try? JSONDecoder().decode(TopRatedResponse.self, from: data)
            return item
        } catch {
            print(error)
             }
        }
        return nil
    }
    
}

