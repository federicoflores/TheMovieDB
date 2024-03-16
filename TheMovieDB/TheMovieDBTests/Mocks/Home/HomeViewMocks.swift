//
//  HomeViewMocks.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation
@testable import TheMovieDB

class HomeViewMocks: HomeViewProtocols {
    
    var numberOfTimesShowLoadingViewCalled: Int = 0
    var numberOfTimesHideLoadingViewCalled: Int = 0
    var numberOfTimesIsEmptyStateHiddenCalled: Int = 0
    var numberOfTimesSetEmptyStateSubtitleCalled: Int = 0
    var numberOfTimesInsertRowsCalled: Int = 0
    
    
    func showLoadingView() {
        numberOfTimesShowLoadingViewCalled += 1
    }
    
    func hideLoadingView() {
        numberOfTimesHideLoadingViewCalled += 1
    }
    
    func isEmptyStateHidden(isHidden: Bool) {
        numberOfTimesIsEmptyStateHiddenCalled += 1
    }
    
    func setEmptyStateSubtitle(subtitle: String) {
        numberOfTimesSetEmptyStateSubtitleCalled += 1
    }
    
    func insertRows(indexPath: [IndexPath]) {
        numberOfTimesInsertRowsCalled += 1
    }
    
}
