//
//  SplashViewController.swift
//  Tracker
//
//  Created by Marina Kireeva on 13.04.2025.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switchToTabBarController()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "Blue")
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            view.addSubview(imageView)
            imageView.image = UIImage(named: "Logo")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Methods
    private func switchToTabBarController() {
        // Получаем экземпляр `window` приложения
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("SplashViewController: Invalid tabBarController Window configuration")
            return
        }
        
        let tabBarController = TabBarController()
        
        // Установим в `rootViewController` полученный контроллер
        window.rootViewController = tabBarController
    }
}

