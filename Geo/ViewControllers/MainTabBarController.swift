//
//  MainViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 02/03/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        UITabBar.appearance().tintColor = .systemGreen
        
        let homeVC = createNavigationControllers(title: "Home", imageName: "house.fill", viewController: HomeViewController())
        let dummyLogout = createNavigationControllers(title: "Logout", imageName: "", viewController: DummyLogoutVC())
        
        viewControllers = [homeVC, dummyLogout]
        
    }
}


extension MainTabBarController {
  
    func createNavigationControllers(title: String, imageName: String, viewController: UIViewController) -> UINavigationController {
        
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.title = title
        navVC.tabBarItem.image = UIImage(systemName: imageName)
        
        return navVC
        
    }
    
}
