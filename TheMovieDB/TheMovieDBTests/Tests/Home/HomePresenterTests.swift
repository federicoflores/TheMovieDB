//
//  HomePresenterTests.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import XCTest
@testable import TheMovieDB

final class HomePresenterTests: XCTestCase {

    var sut: HomePresenter?
    var view: HomeViewMocks?
    var interactor: HomeInteractorMocks?
    var router: HomeRouterMocks?

    override func setUpWithError() throws {
        sut = HomePresenter()
        view = HomeViewMocks()
        router = HomeRouterMocks()
        interactor = HomeInteractorMocks()
        
        sut?.homeInteractor = interactor
        sut?.homeRouter = router
        sut?.homeView = view
    }

    override func tearDownWithError() throws {
        sut = nil
        view = nil
        router = nil
        interactor = nil
    }
    
    
    func fetchTopRatedMovies() {
        sut?.fetchTopRatedMovies()
        XCTAssertEqual(view?.numberOfTimesShowLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesShowLoadingViewCalled, 2)
        XCTAssertEqual(interactor?.numberOfTimesFetchTopRatedMoviesCalled, 1)
        XCTAssertNotEqual(interactor?.numberOfTimesFetchTopRatedMoviesCalled, 2)
    }
    
    func testOnFetchTopRatedMoviesSuccess() {
        sut?.onFetchTopRatedMoviesSuccess(response: TopRatedResponse(results: []))
        
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 2)
        
        XCTAssertEqual(view?.numberOfTimesInsertRowsCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesInsertRowsCalled, 2)
        
        XCTAssertEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 2)
    }
    
    func testOnFetchTopRatedMoviesFail() {
        sut?.onFetchTopRatedMoviesFail(error: "")
        
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 2)
        
        XCTAssertEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 2)
        
        XCTAssertEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesIsEmptyStateHiddenCalled, 2)
    }
    
    func testDidSelectRow() {
        sut?.topRatedMoviesResponse = JSONLoader().topRatedMoviesResponse() ?? TopRatedResponse(results: [])
        sut?.didSelectRow(at: 1)
        
        XCTAssertEqual(router?.numberOfTimesGoToDetailCalled, 1)
        XCTAssertNotEqual(router?.numberOfTimesGoToDetailCalled, 2)
    }

}
