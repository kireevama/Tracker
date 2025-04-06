//
//  TabBarController.swift
//  Tracker
//
//  Created by Marina Kireeva on 06.04.2025.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "White [day]")
        setupTabs()
    }
    
    private func setupTabs() {
        let trackerViewController = TrackerViewController()
        trackerViewController.tabBarItem.title = "Трекеры"
        trackerViewController.tabBarItem.image = UIImage(named: "iconCircle")
  
        
        let statisticViewController = StatisticViewController()
        statisticViewController.tabBarItem.title = "Статистика"
        statisticViewController.tabBarItem.image = UIImage(named: "iconRabbit")
        
        setViewControllers([trackerViewController, statisticViewController], animated: false)
        tabBar.tintColor = UIColor(named: "Blue")
        tabBar.backgroundColor = UIColor(named: "White [day]")
    }

}
