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
        let mapVC = createNavigationControllers(title: "Map", imageName: "map.fill", viewController: MapViewController())
        let listVC = createNavigationControllers(title: "List", imageName: "list.bullet", viewController: ListViewController())
        let settingsVC = createNavigationControllers(title: "Settings", imageName: "gearshape.fill", viewController: SettingsViewController())
        
        viewControllers = [homeVC, mapVC, listVC, settingsVC]
        
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
