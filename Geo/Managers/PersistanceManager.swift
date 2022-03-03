//
//  PersistanceManager.swift
//  Geo
//
//  Created by Damian Durzyński on 28/02/2022.
//

import Foundation

struct PersistanceManager {
    
    static let shared = PersistanceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    enum Keys: String {
        case hasOnboarded
        case email
        case name
    }
    
    var hasOnboarded: Bool {
        return userDefaults.bool(forKey: Keys.hasOnboarded.rawValue)
    }
    
    var userEmail: String {
        return userDefaults.string(forKey: Keys.email.rawValue) ?? ""
    }
    
    var userName: String {
        return userDefaults.string(forKey: Keys.name.rawValue) ?? ""
    }
    
}
