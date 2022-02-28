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
    }
    
    var hasOnboarded: Bool {
        return userDefaults.bool(forKey: Keys.hasOnboarded.rawValue)
    }
    
}
