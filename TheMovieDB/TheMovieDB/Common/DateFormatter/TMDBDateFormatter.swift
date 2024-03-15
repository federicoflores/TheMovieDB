//
//  TMDBDateFormatter.swift
//  TheMovieDB
//
//  Created by Fede Flores on 15/03/2024.
//

import Foundation

struct TMDBDateFormatter {
    
    let dateFormatter = DateFormatter()
    
    enum DateFormat: String {
        case yearMonthDay = "yyyy-MM-dd"
        case dayMonthYear = "dd/MM/yyyy"
    }
    
    func formatStringDate(stringDate: String, from initialDateFormat: DateFormat, to finalDateFormat: DateFormat) -> String {
        dateFormatter.dateFormat = initialDateFormat.rawValue
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat = finalDateFormat.rawValue
        guard let date = date else { return ""}
        return dateFormatter.string(from: date)
    }
}
