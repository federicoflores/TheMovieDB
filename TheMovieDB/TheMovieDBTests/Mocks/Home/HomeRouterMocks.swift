//
//  HomeRouterMocks.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation
@testable import TheMovieDB


class HomeRouterMocks: HomeRouterProtocols {
    
    var numberOfTimesGoToDetailCalled = 0
    
    func goToDetail(with viewModel: TheMovieDB.DetailMovieViewModel) {
        numberOfTimesGoToDetailCalled += 1
    }
    
}
