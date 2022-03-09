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
        case locationEnabled
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
    
    var locationEnabled: Bool {
        return userDefaults.bool(forKey: Keys.locationEnabled.rawValue)
    }
    
    func setupUser(user: User) {
        
        userDefaults.set(user.name, forKey: Keys.name.rawValue)
        userDefaults.set(user.email, forKey: Keys.email.rawValue)
        
    }
    
    func saveUserLocation(latitude: Double, longitude: Double) {
        userDefaults.set(latitude, forKey: Keys.latitude.rawValue)
        userDefaults.set(longitude, forKey: Keys.longitude.rawValue)
    }
    
    func setupLocationEnabled(enabled: Bool) {
        userDefaults.set(enabled, forKey: Keys.locationEnabled.rawValue)
    }
    
}
