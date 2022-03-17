//
//  UserViewModel.swift
//  Geo
//
//  Created by Damian Durzyński on 03/03/2022.
//

import Foundation

struct UserViewModel {
    
    var name: String {
        return UserDefaults.standard.string(forKey: K.UserDefaultsKeys.name) ?? ""
    }

    var email: String {
        return UserDefaults.standard.string(forKey: K.UserDefaultsKeys.email) ?? ""
    }
    
    func myUser() -> User {
        let myUser = User(email: email, name: name)
        
        return myUser
    }
    
}
