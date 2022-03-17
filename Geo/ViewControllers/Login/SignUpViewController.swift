//
//  SignUpViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 28/02/2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    public var completion: (() -> Void)?
    
    private var email: String {
        return emailTextFieldView.textField.text ?? ""
    }
    
    private var name: String {
        return nameTextFieldView.textField.text ?? ""
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
        imageView.image = UIImage(systemName: K.appLogoImageName)
        imageView.tintColor = .systemGreen
        
        return imageView
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.font = .rounded(ofSize: 40, weight: .semibold)
        label.text = K.appName
        
        return label
    }()
    
    private let signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .rounded(ofSize: 24, weight: .semibold)
        label.text = K.Login.register
        
        return label
    }()
    
    private let emailTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldLabel.text = K.Login.email
        
        view.textField.placeholder = K.Login.email
        view.textField.returnKeyType = .next
        view.textField.isUserInteractionEnabled = true
        
        return view
    }()
    
    private let nameTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldLabel.text = K.Login.name
        
        view.textField.placeholder = K.Login.name
        view.textField.returnKeyType = .next
        view.textField.isUserInteractionEnabled = true
        
        return view
    }()
    
    private let passwordTextFieldView: LoginTextFieldView = {
        let view = LoginTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldLabel.text = K.Login.password
        
        view.textField.placeholder = K.Login.password
        view.textField.returnKeyType = .done
        view.textField.isSecureTextEntry = true
        view.textField.isUserInteractionEnabled = true
        
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .systemBackground
        button.configuration?.buttonSize = .large
        button.setTitle(K.signUp, for: [])
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)

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

extension SignUpViewController {
    
    func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(signUpStackView)
        
        signUpStackView.addArrangedSubview(logoStackView)
        
        logoStackView.addArrangedSubview(logoImageView)
        logoStackView.addArrangedSubview(logoLabel)
        

        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(emailTextFieldView)
        signUpStackView.addArrangedSubview(nameTextFieldView)
        signUpStackView.addArrangedSubview(passwordTextFieldView)
        signUpStackView.addArrangedSubview(signUpButton)
    }
    
    func layoutUI() {
        
        NSLayoutConstraint.activate([
        
            // Stack View
            
            signUpStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            signUpStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signUpStackView.trailingAnchor, multiplier: 1),
            
            // Image
            
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),

        ])
        
    }
    
}

//MARK: - Actions

extension SignUpViewController {
    
    @objc func signUpTapped() {
        
        var title: String
        var message: String
        
        if !email.isValidEmail() {
            
            title = K.Login.signUpErrorEmailTitleText
            message = K.Login.signUpErrorEmailMessageText
            presentSignUpError(title: title, message: message)
            return
        }
        
        if !name.isValidName() {
            title = K.Login.signUpErrorNameTitleText
            message = K.Login.signUpErrorNameMessageText
            presentSignUpError(title: title, message: message)
            return
        }
        
        if !password.isValidPassword() {
            title = K.Login.signUpErrorPassowordTitleText
            message = K.Login.signUpErrorPassowordMessageText
            presentSignUpError(title: title, message: message)
            return
        }
        
        AuthManager.shared.singUp(email: email, name: name, password: password) { [weak self] result in
            
            switch result {
            case .success(let user):
                
                PersistanceManager.shared.setupUser(user: user)
                
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completion?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - TextField Delegate

extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {

        case emailTextFieldView.textField:
            nameTextFieldView.textField.becomeFirstResponder()
        case nameTextFieldView.textField:
            passwordTextFieldView.textField.becomeFirstResponder()
        case passwordTextFieldView.textField:

            signUpTapped()

        default:
            print("Error with return button.")

        }

        return true
    }
    
}
