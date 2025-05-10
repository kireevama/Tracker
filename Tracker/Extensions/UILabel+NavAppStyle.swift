//
//  UILabel+NavAppStyle.swift
//  Tracker
//
//  Created by Marina Kireeva on 29.04.2025.
//

import UIKit

extension UILabel {
    static func createNavAppStyleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "Black [day]")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
