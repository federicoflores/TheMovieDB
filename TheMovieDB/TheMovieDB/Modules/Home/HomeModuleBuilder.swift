//
//  HomeModuleBuilder.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import UIKit

class HomeModuleBuilder {
    static func build() -> UIViewController {
        let view: HomeViewController = HomeViewController()
        let presenter: HomePresenter = HomePresenter()
        let interactor: HomeInteractor = HomeInteractor(provider: BaseRepository())
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
