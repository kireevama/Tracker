//
//  UIButton+Extensions.swift
//  Tracker
//
//  Created by Marina Kireeva on 29.04.2025.
//

import UIKit

extension UIButton {
    static func createNormalStyleButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(named: "Black [day]")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.tintColor = UIColor(named: "White [day]")
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
