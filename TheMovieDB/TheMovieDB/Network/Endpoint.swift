//
//  Endpoint.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var headers: [String: String]? { get }
}
