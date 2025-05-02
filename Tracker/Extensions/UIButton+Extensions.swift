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
        button.setTitleColor(UIColor(named: "White [day]"), for: .normal)
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    static func createCancelStyleButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(named: "White [day]")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(named: "Red"), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.borderColor = (UIColor(named: "Red") ?? .red).cgColor
        button.layer.borderWidth = 1
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    static func createNoActiveStyleButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(named: "Gray")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(named: "White [day]"), for: .normal)
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
