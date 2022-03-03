//
//  MainViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 02/03/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        layoutUI()
    }
}


extension MainViewController {
    func styleUI() {
        
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        button.setTitle("Sing Out", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
    }
    
    func layoutUI() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
        label.text = UserDefaults.standard.string(forKey: "name")
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension MainViewController {
    
    @objc func signOutTapped() {
        
        AuthManager.shared.signOut { [weak self] success in
            
            DispatchQueue.main.async {
                let vc = UINavigationController(rootViewController: SignInViewController())
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self?.present(vc, animated: true, completion: nil)
                
            }
        }
        
    }
    
}
