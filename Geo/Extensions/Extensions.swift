//
//  Extensions.swift
//  Geo
//
//  Created by Damian Durzyński on 26/02/2022.
//

import UIKit

//MARK: - UIViewController

extension UIViewController {
    
    func presentSignInError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = .systemGreen
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func presentSignUpError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = .systemGreen
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

//MARK: - String

extension String {
    
    func isValidUsername() -> Bool {
        let regEx = "[A-Za-z]\\w{2,18}"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regEx = "\\w{6,18}"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }

}

//MARK: - UIFont

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}
