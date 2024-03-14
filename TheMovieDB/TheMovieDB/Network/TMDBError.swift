//
//  Errors.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

enum TMDBError: Error {
    case invalidDecoding
    case invalidURL
    case invalidAPIKey
}
