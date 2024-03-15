//
//  AppConfigurationManager.swift
//  TheMovieDB
//
//  Created by Fede Flores on 12/03/2024.
//

import Foundation

import Foundation

protocol AppConfigurationManagerType {
    func getAppConfiguration(with name: AppConfigurationManager.AppConfigurationNames) -> String?
}

class AppConfigurationManager: AppConfigurationManagerType {
    
    enum AppConfigurationNames: String {
        case API_KEY
        case ACCESS_TOKEN
    }
    
    static let shared: AppConfigurationManagerType = AppConfigurationManager()
    
    func getAppConfiguration(with name: AppConfigurationNames) -> String? {
        Bundle.main.object(forInfoDictionaryKey: name.rawValue) as? String
    }
    
}
