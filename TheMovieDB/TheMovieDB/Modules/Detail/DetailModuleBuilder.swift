//
//  DetailModuleBuilder.swift
//  TheMovieDB
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation

import UIKit

class DetailModuleBuilder {
    static func build(with detailMovieViewModel: DetailMovieViewModel) -> UIViewController {
        let view: DetailViewController = DetailViewController(viewModel: detailMovieViewModel)
        let presenter: DetailPresenter = DetailPresenter()
        let router: DetailRouter = DetailRouter()
        
        view.presenter = presenter
        
        presenter.detailView = view
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
}
