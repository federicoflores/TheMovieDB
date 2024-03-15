//
//  DetailRouter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 15/03/2024.
//

import UIKit

protocol DetailRouterProtocols: AnyObject {
    func presentPopup(title: String, subtitle: String, action: (()->())?)
}


class DetailRouter: DetailRouterProtocols {
    
    weak var viewController: UIViewController?
    
    func presentPopup(title: String, subtitle: String, action: (()->())?) {
        guard let viewController = viewController else { return }
        let alertView = CustomAlertViewController()
        alertView.titleText = title
        alertView.subtitleText = subtitle
        alertView.mainAction = action

        UIView.transition(with: viewController.view, duration: 0.5, options: [.transitionCrossDissolve]) {
            viewController.addChild(alertView)
            viewController.view.addSubview(alertView.view)
        }
    }
}
