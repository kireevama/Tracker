//
//  ViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 06.04.2025.
//

import UIKit

class TrackerViewController: UIViewController {
    // MARK: - Propertys
    let topNavView: UIView = {
        let topNavView = UIView()
        
        return topNavView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topNavView)
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        lazy var plusButton: UIButton = {
            let button = UIButton()
            
            let imageView = UIImageView.init(image: UIImage(named: "iconPlus"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 19).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 19).isActive = true
            button.addSubview(imageView)
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 42).isActive = true
            button.heightAnchor.constraint(equalToConstant: 42).isActive = true
            
            return button
        }()
        
        lazy var datePicker: UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.preferredDatePickerStyle = .compact
            datePicker.datePickerMode = .date
            
            return datePicker
        }()
        
        let hStack: UIStackView = {
            let stack = UIStackView()
            topNavView.addSubview(stack)
            stack.axis = .horizontal
            stack.alignment = .center
            stack.addArrangedSubview(plusButton)
            stack.addArrangedSubview(datePicker)
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                stack.heightAnchor.constraint(equalToConstant: 42),
            ])
            
            return stack
        }()
        
        let label: UILabel = {
            let label = UILabel()
            topNavView.addSubview(label)
            label.text = "Трекеры"
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.textColor = UIColor(named: "Black [day]")
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 2),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ])
            
            return label
        }()
        
        var searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            topNavView.addSubview(searchBar)
            searchBar.placeholder = "Поиск"
            searchBar.backgroundImage = UIImage() // убираем линии
            
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 7),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            
            return searchBar
        }()
        
        NSLayoutConstraint.activate([
            topNavView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topNavView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topNavView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        getStubScreen(imageName: "star", text: "Что будем отслеживать?", view: self.view)
    }
    
    
}
