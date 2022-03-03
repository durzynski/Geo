//
//  LoginTextFieldView.swift
//  Geo
//
//  Created by Damian Durzyński on 27/02/2022.
//

import Foundation
import UIKit

class LoginTextFieldView: UIView {
    
    //MARK: - UI Elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    let textFieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 8
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

//MARK: - Configure UI

extension LoginTextFieldView {
    
    func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(textFieldLabel)
        stackView.addArrangedSubview(textField)
        
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
}
