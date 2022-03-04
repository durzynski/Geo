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
        case latitude
        case longitude
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
    
    var latitude: Double {
        return userDefaults.double(forKey: Keys.latitude.rawValue)
    }
    
    var longitude: Double {
        return userDefaults.double(forKey: Keys.longitude.rawValue)
    }
    
    func setupUser(user: User) {
        
        UserDefaults.standard.set(user.name, forKey: Keys.name.rawValue)
        UserDefaults.standard.set(user.email, forKey: Keys.email.rawValue)
        
    }
    
    func saveUserLocation(latitude: Double, longitude: Double) {
        UserDefaults.standard.set(latitude, forKey: Keys.latitude.rawValue)
        UserDefaults.standard.set(longitude, forKey: Keys.longitude.rawValue)
    }
    
}
