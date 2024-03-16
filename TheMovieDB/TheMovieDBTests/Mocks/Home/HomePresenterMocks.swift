//
//  HomePresenterMocks.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation
@testable import TheMovieDB


class HomePresenterMocks: HomePresenterProtocols {
    var topRatedMoviesResponse: TheMovieDB.TopRatedResponse = JSONLoader().topRatedMoviesResponse() ?? TopRatedResponse(results: [])
    
    var numberOfTimesFetchTopRatedMoviesCalled: Int = 0
    var numberOfTimesOnFetchTopRatedMoviesSuccessCalled: Int = 0
    var numberOfTimesOnFetchTopRatedMoviesFailCalled: Int = 0
    var numberOfTimesNumberOfRowsInSectionCalled: Int = 0
    var numberOfTimesDidSelectRowCalled: Int = 0
    var numberOfTimesGetTopRatedMovieViewModelCalled: Int = 0
    var numberOfTimesDidScrollToBottomCalled: Int = 0
    
    func fetchTopRatedMovies() {
        numberOfTimesFetchTopRatedMoviesCalled += 1
    }
    
    func onFetchTopRatedMoviesSuccess(response: TheMovieDB.TopRatedResponse) {
        numberOfTimesOnFetchTopRatedMoviesSuccessCalled += 1
    }
    
    func onFetchTopRatedMoviesFail(error: String) {
        numberOfTimesOnFetchTopRatedMoviesFailCalled += 1
    }
    
    func numberOfRowsInSection() -> Int {
        numberOfTimesNumberOfRowsInSectionCalled += 1
        return 1
    }
    
    func didSelectRow(at indexPath: Int) {
        numberOfTimesDidSelectRowCalled += 1
    }
    
    func getTopRatedMovieViewModel(from row: Int) -> TheMovieDB.HomeMovieViewModel? {
        numberOfTimesGetTopRatedMovieViewModelCalled += 1
        return HomeMovieViewModel(title: "", releaseDate: "", posterPath: "")
    }
    
    func didScrollToBottom(row: Int) -> Bool {
        numberOfTimesDidScrollToBottomCalled += 1
        return true
    }
    
}
