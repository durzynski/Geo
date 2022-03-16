//
//  SignOutViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 09/03/2022.
//

import Foundation
import UIKit

protocol SignOutViewControllerDelegate: AnyObject {
    func didSignOut()
}

class SignOutViewController: UIViewController {
    
    weak var delegate: SignOutViewControllerDelegate?
    
    //MARK: - UI Elements
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        button.configuration?.baseBackgroundColor = .systemRed
        button.configuration?.baseForegroundColor = .systemRed
        button.configuration?.buttonSize = .large
        button.setTitle("Sing out", for: [])
        button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layoutUI()
    }
}

//MARK: - Configure UI

extension SignOutViewController {
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(signOutButton)
        
    }
    
    private func layoutUI() {

        
        NSLayoutConstraint.activate([
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            signOutButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signOutButton.trailingAnchor, multiplier: 1),
        
            
        ])
    }
}

//MARK: - Actions

extension SignOutViewController {
    @objc func signOutTapped() {
        
        NotificationCenter.default.post(name: .signOut, object: nil)
        
        self.delegate?.didSignOut()
        
    }
}


