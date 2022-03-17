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
        
        let homeVC = createNavigationControllers(title: K.MainTabBar.homeTitle, imageName: K.MainTabBar.homeImageName, viewController: HomeViewController())
        let mapVC = createNavigationControllers(title: K.MainTabBar.mapTitle, imageName: K.MainTabBar.mapImageName, viewController: MapViewController())
        let listVC = createNavigationControllers(title: K.MainTabBar.listTitle, imageName: K.MainTabBar.listImageName, viewController: ListViewController())
        let settingsVC = createNavigationControllers(title: K.MainTabBar.settingsTitle, imageName: K.MainTabBar.settingsImageName, viewController: SettingsViewController())
        
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
