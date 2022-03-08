//
//  DatabaseManager.swift
//  Geo
//
//  Created by Damian Durzyński on 02/03/2022.
//

import Foundation
import Firebase

struct DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public func fetchPlaces(completion: @escaping ([Place]?) -> Void) {
        
        let reference = database.collection("places")
        
        reference.getDocuments { querySnapshot, error in
            
            guard let places = querySnapshot?.documents.compactMap({ Place(with: $0.data()) }), error == nil else {
                completion(nil)
                return
            }
            completion(places)
        }
        

        
    }
    
    public func findUser(with email: String, completion: @escaping (User?) -> Void) {
        
        let reference = database.collection("users").document(email)
        
        reference.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let user = User(with: data ?? ["": ""])
                completion(user)
            } else {
                completion(nil)
            }
        }
        
    }
    
    public func createNewUser(newUser: User, completion: @escaping (Bool) -> Void) {
        
        let reference = database.document("users/\(newUser.email)")
        
        guard let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        
        reference.setData(data) { error in
            completion(error == nil)
        }
        
    }
    
}
