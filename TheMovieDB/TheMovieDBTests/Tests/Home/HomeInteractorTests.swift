//
//  HomeInteractorTests.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import XCTest
@testable import TheMovieDB

final class HomeInteractorTests: XCTestCase {

    var presenter: HomePresenterMocks?
    var sut: HomeInteractor?
    
    override func setUpWithError() throws {
        sut = HomeInteractor(repository: BaseRepositoryStub())
        presenter = HomePresenterMocks()
        sut?.homePresenter = presenter
    }
    
    func testFetchTopRatedMovies() {
        sut?.fetchTopRatedMovies(page: 1)
        
        XCTAssertEqual(presenter?.numberOfTimesOnFetchTopRatedMoviesSuccessCalled, 1)
        XCTAssertNotEqual(presenter?.numberOfTimesOnFetchTopRatedMoviesSuccessCalled, 0)
    }

}
