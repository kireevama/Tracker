//
//  CreateTrackerController.swift
//  Tracker
//
//  Created by Marina Kireeva on 29.04.2025.
//

import UIKit

final class CreateTrackerController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "White [day]")
        setupUI()
    }
    
    private func setupUI() {
        let topLabel = UILabel.createNavAppStyleLabel(title: "Создание трекера")
        view.addSubview(topLabel)
        
        let createHabitButton = UIButton.createNormalStyleButton(title: "Привычка")
        let createIrregularEventButton = UIButton.createNormalStyleButton(title: "Нерегулярное событие")
        
        let vStack: UIStackView = {
            let stack = UIStackView()
            view.addSubview(stack)
            stack.axis = .vertical
            stack.alignment = .center
            stack.addArrangedSubview(createHabitButton)
            stack.addArrangedSubview(createIrregularEventButton)
            stack.spacing = 16
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            return stack
        }()
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createHabitButton.heightAnchor.constraint(equalToConstant: 60),
            createIrregularEventButton.heightAnchor.constraint(equalToConstant: 60),
            createHabitButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            createIrregularEventButton.widthAnchor.constraint(equalTo: vStack.widthAnchor)
        ])
    }
}
