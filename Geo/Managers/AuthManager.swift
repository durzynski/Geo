//
//  AuthManager.swift
//  Geo
//
//  Created by Damian Durzyński on 28/02/2022.
//

import Foundation
import Firebase

struct AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    enum AuthError: Error {
        case signUpFailed
        case signInFailed
        case newUserCreation
    }
    
    public var isSignedIn: Bool {
    
        return auth.currentUser != nil
        
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        DatabaseManager.shared.findUser(with: email) { user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }
            
            self.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }
            
                PersistanceManager.shared.setupUser(user: user)
                
                completion(.success(user))
                
            })
        }
        
    }
    
    
    public func singUp(email: String, name: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let newUser = User(email: email, name: name)
        
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(AuthError.signUpFailed))
                return
            }
            
            DatabaseManager.shared.createNewUser(newUser: newUser) { success in
             
                if success {
                    completion(.success(newUser))
                } else {
                    completion(.failure(AuthError.newUserCreation))
                }
            }
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        
        do {
            try auth.signOut()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
    
}
