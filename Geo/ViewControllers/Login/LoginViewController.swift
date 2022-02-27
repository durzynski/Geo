//
//  LoginViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 25/02/2022.
//

import UIKit

class LoginViewController: UIViewController {

    private var email: String {
        return usernameTextFieldView.textField.text ?? ""
    }
    
    private var password: String {
        return passwordTextFieldView.textField.text ?? ""
    }
    
    //MARK: - UI Elements
    
    private let logoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "shippingbox.fill")
        imageView.tintColor = .systemGreen
        
        return imageView
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.font = .rounded(ofSize: 40, weight: .semibold)
        label.text = "Geo"
        
        return label
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .rounded(ofSize: 24, weight: .semibold)
        label.text = "Login"
        
        return label
    }()
    
    private let usernameTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldLabel.text = "Username"
        
        view.textField.placeholder = "Username"
        view.textField.returnKeyType = .next
        view.textField.isUserInteractionEnabled = true
        
        return view
    }()
    
    private let passwordTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldLabel.text = "Password"
        
        view.textField.placeholder = "Password"
        view.textField.returnKeyType = .done
        view.textField.isSecureTextEntry = true
        view.textField.isUserInteractionEnabled = true
        
        return view
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .systemBackground
        button.configuration?.buttonSize = .large
        button.setTitle("Sing in", for: [])
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)

        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.baseForegroundColor = .systemGreen
        button.configuration?.buttonSize = .large
        button.setTitle("No account yet? Sign up", for: [])
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setup()
        layout()
        
    }


}

//MARK: - Configure UI

extension LoginViewController {
    
    func setup() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginStackView)
        
        loginStackView.addArrangedSubview(logoStackView)
        
        logoStackView.addArrangedSubview(logoImageView)
        logoStackView.addArrangedSubview(logoLabel)
        

        loginStackView.addArrangedSubview(loginLabel)
        loginStackView.addArrangedSubview(usernameTextFieldView)
        loginStackView.addArrangedSubview(passwordTextFieldView)
        loginStackView.addArrangedSubview(signInButton)
        loginStackView.addArrangedSubview(signUpButton)
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
        
            // Stack View
            
            loginStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            loginStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginStackView.trailingAnchor, multiplier: 1),
            
            // Image
            
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),

        ])
        
    }
    
}

//MARK: - Actions

extension LoginViewController {
    @objc func signInTapped() {
        print("Sign In tapped")
    }
    
    @objc func signUpTapped() {
        print("Sign Up tapped")
    }
}

