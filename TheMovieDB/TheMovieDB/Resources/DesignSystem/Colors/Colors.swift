//
//  Colors.swift
//  TheMovieDB
//
//  Created by Fede Flores on 12/03/2024.
//

import UIKit

enum TMDBColor: CaseIterable {
    
    case main900
    case main800
    case main700
    case main600
    case main500
    case main400
    case main300
    case main200
    case main100
    case main00
    
    var color: UIColor {
        switch self {
        case .main900:
            return UIColor(hexString: "003A40")
        case .main800:
            return UIColor(hexString: "336166")
        case .main700:
            return UIColor(hexString: "66898C")
        case .main600:
            return UIColor(hexString: "809DA0")
        case .main500:
            return UIColor(hexString: "99B0B3")
        case .main400:
            return UIColor(hexString: "B3C4C6")
        case .main300:
            return UIColor(hexString: "CCD8D9")
        case .main200:
            return UIColor(hexString: "E6EBEC")
        case .main100:
            return UIColor(hexString: "F3F5F6")
        case .main00:
            return UIColor(hexString: "FFFFFF")
        }
    }
}


