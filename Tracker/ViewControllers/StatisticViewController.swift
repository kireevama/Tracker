//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 06.04.2025.
//

import UIKit

class StatisticViewController: UIViewController {
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
        var label: UILabel = {
            let label = UILabel()
            label.text = "Статистика"
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.textColor = UIColor(named: "Black [day]")
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        topNavView.addSubview(label)
        topNavView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topNavView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topNavView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topNavView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topNavView.topAnchor, constant: 44),
            label.leadingAnchor.constraint(equalTo: topNavView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: topNavView.trailingAnchor, constant: -16),
        ])
        
        getStubScreen(imageName: "statistics", text: "Анализировать пока нечего", view: view)
    }
}
