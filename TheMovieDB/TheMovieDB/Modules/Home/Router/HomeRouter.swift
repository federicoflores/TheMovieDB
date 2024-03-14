//
//  HomeRouter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import UIKit

protocol HomeRouterProtocols: AnyObject {
    func goToDetail()
}


class HomeRouter: HomeRouterProtocols {
    
    weak var viewController: UIViewController?
    
    func goToDetail() {
        let vc = UIViewController()
        vc.view.backgroundColor = TMDBColor.main400.color
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
