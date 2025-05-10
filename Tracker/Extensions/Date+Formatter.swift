//
//  Date+Formatter.swift
//  Tracker
//
//  Created by Marina Kireeva on 10.05.2025.
//

import Foundation

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
