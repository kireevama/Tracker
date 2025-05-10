//
//  UIButton+Extensions.swift
//  Tracker
//
//  Created by Marina Kireeva on 29.04.2025.
//

import UIKit

extension UIButton {
    static func createNormalStyleButton(title: String) -> UIButton {
        baseButton(title: title,
                   titleColor: UIColor(named: "White [day]"),
                   backgroundColor: UIColor(named: "Black [day]"),
                   borderColor: nil)
    }
    
    static func createCancelStyleButton(title: String) -> UIButton {
        baseButton(title: title,
                   titleColor: UIColor(named: "Red"),
                   backgroundColor: UIColor(named: "White [day]"),
                   borderColor: UIColor(named: "Red"))
    }
    
    static func createNoActiveStyleButton(title: String) -> UIButton {
        baseButton(title: title,
                   titleColor: UIColor(named: "White [day]"),
                   backgroundColor: UIColor(named: "Gray"),
                   borderColor: nil)
    }
    
    private static func baseButton(title: String,
                                   titleColor: UIColor?,
                                   backgroundColor: UIColor?,
                                   borderColor: UIColor?) -> UIButton {
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let borderColor = borderColor {
            button.layer.borderColor = borderColor.cgColor
            button.layer.borderWidth = 1
        }
        
        return button
    }
}
