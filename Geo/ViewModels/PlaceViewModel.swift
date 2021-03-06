//
//  PlaceViewModel.swift
//  Geo
//
//  Created by Damian Durzyński on 03/03/2022.
//

import Foundation
import CoreLocation
import UIKit

//MARK: - List

struct PlaceListViewModel {
    var places: [Place] = [] 
    var savedPlaces: [Places] = []
}

extension PlaceListViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.places.count
    }
    
    func placeAtIndex(_ index: Int) -> PlaceViewModel {
     
        let place = self.places[index]
        
        return PlaceViewModel(place)
    }
    
    func sortedPlaceAtIndex(_ index: Int, maxLength: Int? = nil) -> PlaceViewModel {
        let places = self.places
        var placesVM: [PlaceViewModel] = []
        
        for place in places {
            placesVM.append(PlaceViewModel(place))
        }
        
        var sorted = placesVM.sorted(by: {$0.distanceValue < $1.distanceValue })
        
        guard let maxLength = maxLength else {
            return sorted[index]
        }

        sorted = sorted.prefix(maxLength).map{ $0 }
        
        return sorted[index]
    }
    
    func placeAtIndexFromCoreData(_ index: Int) -> PlaceViewModel {
        
        let places = self.savedPlaces[index]
        let place = Place(name: places.name ?? "",
                          difficulty: places.difficulty ?? "",
                          hint: places.hint ?? "",
                          description: places.placeDescription ?? "",
                          latitude: places.latitude,
                          longitude: places.longitude,
                          size: places.size ?? "")
        
        return PlaceViewModel(place)
    }
    
    func numberOfRowsInSectionCoreData(_ section: Int) -> Int {
        return self.savedPlaces.count
    }
}

//MARK: - Single Element

struct PlaceViewModel {
    private let place: Place
}

extension PlaceViewModel {

    init(_ place: Place) {
        self.place = place
    }
    
    var name: String {
        return self.place.name
    }
    
    var difficulty: String {
        return self.place.difficulty
    }
    
    var difficultyColor: UIColor {
        switch difficulty {
        case K.ViewModelKeys.easy:
            return .systemGreen
        case K.ViewModelKeys.medium:
            return .systemYellow
        case K.ViewModelKeys.hard:
            return .systemRed
        default:
            return .label
        }
    }
    
    var hint: String {
        return self.place.hint
    }
    
    var description: String {
        return self.place.description
    }

    var latitude: Double {
        return self.place.latitude
    }
    
    var longitude: Double {
        return self.place.longitude
    }

    
    var size: String {
        return self.place.size
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    

    
    var distanceValue: Int {
        let placeCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        let userCoordinate = CLLocation(latitude: PersistanceManager.shared.latitude, longitude: PersistanceManager.shared.longitude)
        
        let result = Int(placeCoordinate.distance(from: userCoordinate))
        
        
        return result
    }
    
    var distanceValueInMiles: Double {
        let placeCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        let userCoordinate = CLLocation(latitude: PersistanceManager.shared.latitude, longitude: PersistanceManager.shared.longitude)
        
        let result = Double(placeCoordinate.distance(from: userCoordinate)) / 1609.344
        
        return result
    }
    
    var distance: String {
        
        let unit = PersistanceManager.shared.lengthUnit

        switch unit {
        case K.UserDefaultsKeys.meters:
            
            if distanceValue >= 1000 {
                let resultAsKm = Double(distanceValue)/1000
                let resultString = String(format: "%.2f", resultAsKm)
                return "Distance: \(resultString) km"
            }
            
            return "Distance: \(distanceValue)m"
        
        case K.UserDefaultsKeys.miles:
            
            let resultString = String(format: "%.2f", distanceValueInMiles)
            
            if distanceValueInMiles > 1 {
                
                return "Distance: \(resultString) miles"
            } else {
                return "Distance: \(resultString) mile"
            }

        default:
            return ""
        }
    }
    
    //MARK: - CoreData
   
   func save(with viewModel: PlaceViewModel) {
       let manager = CoreDataManager.shared
       
       let viewModel = viewModel
       let place = Places(context: manager.persistentContainer.viewContext)
       
       place.name = viewModel.name
       place.placeDescription = viewModel.description
       place.size = viewModel.size
       place.hint = viewModel.hint
       place.latitude = viewModel.latitude
       place.longitude = viewModel.longitude
       place.difficulty = viewModel.difficulty
       
//       if CoreDataManager.shared.placeExists(name: viewModel.name) {
//           return
//       }
       
       manager.save()
   }
    
    
    
}
