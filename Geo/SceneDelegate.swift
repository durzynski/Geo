//
//  SceneDelegate.swift
//  Geo
//
//  Created by Damian Durzyński on 25/02/2022.
//

import UIKit
import Lottie

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let loginVC = LoginViewController()
    private let onboardingVC = OnboardingViewController()
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        onboardingVC.delegate = self
        
        if PersistanceManager.shared.hasOnboarded {
            displayLogin()
        } else {
            setRootViewController(vc: onboardingVC)
        }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

extension SceneDelegate {
    
    func displayLogin() {
        setRootViewController(vc: UINavigationController(rootViewController: loginVC))
    }
    
    func setRootViewController(vc: UIViewController, animated: Bool = true) {
        
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
    
}

extension SceneDelegate: OnboardingViewControllerDelegate {
    func didFinishOnboarding() {
        
        UserDefaults.standard.set(true, forKey: PersistanceManager.Keys.hasOnboarded.rawValue)
        
        setRootViewController(vc: loginVC)
    }
}
