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
        let trackersViewController = TrackersViewController()
        trackersViewController.tabBarItem.title = "Трекеры"
        trackersViewController.tabBarItem.image = UIImage(named: "iconCircle")
  
        
        let statisticViewController = StatisticViewController()
        statisticViewController.tabBarItem.title = "Статистика"
        statisticViewController.tabBarItem.image = UIImage(named: "iconRabbit")
        
        setViewControllers([trackersViewController, statisticViewController], animated: false)
        tabBar.tintColor = UIColor(named: "Blue")
        tabBar.backgroundColor = UIColor(named: "White [day]")
    }

}
