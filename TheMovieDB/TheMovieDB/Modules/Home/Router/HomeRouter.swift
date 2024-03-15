//
//  HomeRouter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import UIKit

protocol HomeRouterProtocols: AnyObject {
    func goToDetail(with viewModel: DetailMovieViewModel)
}


class HomeRouter: HomeRouterProtocols {
    
    weak var viewController: UIViewController?
    
    func goToDetail(with viewModel: DetailMovieViewModel) {
        let vc = DetailModuleBuilder.build(with: viewModel)
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
