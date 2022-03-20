//
//  CoreDataManager.swift
//  Geo
//
//  Created by Damian Durzyński on 17/03/2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "PlacesDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func save() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save place. \(error.localizedDescription)")
        }
    }
    
    func fetchPlaces() -> [Places] {
        
        let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func deletePlace(_ place: Places) {
        
        persistentContainer.viewContext.delete(place)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete.")
        }
        
    }
//    func placeExists(name: String) -> Bool {
//        
//        let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
//        let predicate = NSPredicate(format: "name == %@", name)
//        
//        fetchRequest.predicate = predicate
//        
//        do {
//            let count = try persistentContainer.viewContext.count(for: fetchRequest)
//            print(count)
//            if count == NSNotFound {
//                return false
//            }
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        return true
//        
//    }
    
}
