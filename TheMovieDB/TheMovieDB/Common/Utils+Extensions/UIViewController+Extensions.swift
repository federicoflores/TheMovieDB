//
//  UIViewController+Extensions.swift
//  TheMovieDB
//
//  Created by Fede Flores on 12/03/2024.
//

import Foundation

import UIKit

extension UIViewController {
    func showLoadingView() {
        Loader.sharedLoader.show()
    }
    
    func hideLoadingView() {
        Loader.sharedLoader.hide()
    }
}
