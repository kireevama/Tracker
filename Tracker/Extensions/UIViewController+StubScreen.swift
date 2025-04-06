//
//  UIViewController+StubScreen.swift
//  Tracker
//
//  Created by Marina Kireeva on 12.04.2025.
//

import UIKit

extension UIViewController {
    func getStubScreen(imageName: String, text: String, view: UIView) -> UIStackView {
        var imageView: UIImageView = {
            guard let image = UIImage(named: imageName) else {
                print("ViewController: get image error")
                return UIImageView(image: UIImage(systemName: "circle.hexagonpath.fill"))
            }
            
            return UIImageView(image: image)
        }()
        
        var label: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.textColor = UIColor(named: "Black [day]")
            label.numberOfLines = 0
            
            return label
        }()
        
        var vStack: UIStackView = {
            let stack = UIStackView()
            view.addSubview(stack)
            stack.addArrangedSubview(imageView)
            stack.addArrangedSubview(label)
            stack.axis = .vertical
            stack.spacing = 8
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            
            NSLayoutConstraint.activate([
                stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
                stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
            ])
            
            return stack
        }()
        
        return vStack
    }
}
