//
//  SceneDelegate.swift
//  Geo
//
//  Created by Damian Durzyński on 25/02/2022.
//

import UIKit
import Lottie

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let signInVC = SignInViewController()
    private let navSignInVC = UINavigationController(rootViewController: SignInViewController())
    private let signUpVC = SignUpViewController()
    private let onboardingVC = OnboardingViewController()
    private let mainVC = MainViewController()
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        onboardingVC.delegate = self
        
        if AuthManager.shared.isSignedIn {
            setRootViewController(vc: mainVC)
        } else if PersistanceManager.shared.hasOnboarded {
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
        setRootViewController(vc: navSignInVC)
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

//MARK: - OnboardingViewControllerDelegate

extension SceneDelegate: OnboardingViewControllerDelegate {
    func didFinishOnboarding() {
        
        UserDefaults.standard.set(true, forKey: PersistanceManager.Keys.hasOnboarded.rawValue)
        
        setRootViewController(vc: navSignInVC)
    }
}
