//
//  DetailPresenter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation

protocol DetailPresenterProtocols: AnyObject {
    func showAlert()
    func popupMainButtonTapped()
}

class DetailPresenter: DetailPresenterProtocols {
    
    fileprivate enum Wording {
        static let popupTitle: String = "You have selected it as favorite! This is a test line"
        static let popupsSubtitle: String = "Thanks for testing it! This is a test line to check the multiline."
    }
    
    weak var detailView: DetailViewProtocols?
    var router: DetailRouterProtocols?
    
    func showAlert() {
        router?.presentPopup(
            title: Wording.popupTitle,
            subtitle: Wording.popupsSubtitle,
            action: popupMainButtonTapped)
    }
    
    func popupMainButtonTapped() {
        print("Thanks for testing me")
    }
    
}
