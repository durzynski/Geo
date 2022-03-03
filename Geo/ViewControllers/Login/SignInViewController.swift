//
//  SignInViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 25/02/2022.
//

import UIKit
import IQKeyboardManagerSwift

class SignInViewController: UIViewController {
    
    private var email: String {
        return emailTextFieldView.textField.text ?? ""
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
    
    private let emailTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldLabel.text = "Email"
        
        view.textField.placeholder = "Email"
        view.textField.returnKeyType = .next
        view.textField.keyboardType = .emailAddress
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
        view.textField.textContentType = .oneTimeCode
        
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
        button.configuration = .bordered()
        button.configuration?.baseForegroundColor = .systemGreen
        button.configuration?.buttonSize = .large
        button.configuration?.baseBackgroundColor = .systemBackground
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.setTitle("No account yet? Sign up", for: [])
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layoutUI()
        setupNavigation()
    
        emailTextFieldView.textField.delegate = self
        passwordTextFieldView.textField.delegate = self
        
    }


}

//MARK: - Configure UI

extension SignInViewController {
    
    func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginStackView)
        
        loginStackView.addArrangedSubview(logoStackView)
        
        logoStackView.addArrangedSubview(logoImageView)
        logoStackView.addArrangedSubview(logoLabel)
        

        loginStackView.addArrangedSubview(loginLabel)
        loginStackView.addArrangedSubview(emailTextFieldView)
        loginStackView.addArrangedSubview(passwordTextFieldView)
        loginStackView.addArrangedSubview(signInButton)
        loginStackView.addArrangedSubview(signUpButton)
    }
    
    func layoutUI() {
        
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

//MARK: - Setup Navigation

extension SignInViewController {
    
    func setupNavigation() {
        
        navigationController?.navigationBar.tintColor = .label
        
    }
    
}

//MARK: - Actions

extension SignInViewController {
    @objc func signInTapped() {
        
        AuthManager.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    let vc = MainViewController()
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self?.present(vc, animated: true)
                }

            case .failure(_):
                self.presentSignInError(title: "Sign In Error", message: "Your email or password is incorrect. Please try again.")
            }
        }
        
    }
    
    @objc func signUpTapped() {
        
        let vc = SignUpViewController()
        vc.completion = {
            DispatchQueue.main.async { [weak self] in
                let vc = MainViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self?.present(vc, animated: true)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TextField Delegate

extension SignInViewController: UITextFieldDelegate {
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {

        case emailTextFieldView.textField:
            passwordTextFieldView.textField.becomeFirstResponder()
        case passwordTextFieldView.textField:

            signInTapped()

        default:
            print("Error with return button.")

        }

        return true
    }
    
}
