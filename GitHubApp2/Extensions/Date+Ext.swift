//
//  Date+Ext.swift
//  GitHubApp2
//
//  Created by Amrah on 24.04.24.
//

import Foundation

extension Date{
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
