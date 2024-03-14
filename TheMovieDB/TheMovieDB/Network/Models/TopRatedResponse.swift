//
//  TopRatedResponse.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation

struct TopRatedResponse: Decodable {
    var results: [Movie]
}
struct Movie: Decodable {
    let id: Int
    let title: String
    let popularity: Double
    let releaseDate: String
    let posterPath: String
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, popularity, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
