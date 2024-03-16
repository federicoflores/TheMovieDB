//
//  HomeModuleBuilderStub.swift
//  TheMovieDBTests
//
//  Created by Fede Flores on 15/03/2024.
//

import UIKit
@testable import TheMovieDB

class HomeModuleBuilderStub {
    static func build() -> UIViewController {
        let view: HomeViewController = HomeViewController()
        let presenter: HomePresenter = HomePresenter()
        let interactor: HomeInteractor = HomeInteractor(repository: BaseRepositoryStub())
        let router: HomeRouter = HomeRouter()
        
        view.homePresenter = presenter
        
        presenter.homeView = view
        presenter.homeRouter = router
        presenter.homeInteractor = interactor
        
        interactor.homePresenter = presenter
        
        router.viewController = view
        
        return view
    }
}


