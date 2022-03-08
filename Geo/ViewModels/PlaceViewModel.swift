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
    let places: [Place] = [
        Place(name: "Magic Forest", difficulty: .hard, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 67.321372, longitude: 19.268350, size: .small),
        
        Place(name: "Dummy Forest", difficulty: .medium, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 58.321372, longitude: 15.268350, size: .small),
        
        Place(name: "Scary road", difficulty: .easy, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 30.321372, longitude: 17.268350, size: .small),
        Place(name: "Magic Forest", difficulty: .hard, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 67.321372, longitude: 19.268350, size: .small),
        
        Place(name: "Dummy Forest", difficulty: .medium, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 58.321372, longitude: 15.268350, size: .small),
        
        Place(name: "Scary road", difficulty: .easy, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 30.321372, longitude: 17.268350, size: .small),
        Place(name: "Magic Forest", difficulty: .hard, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 67.321372, longitude: 19.268350, size: .small),
        
        Place(name: "Dummy Forest", difficulty: .medium, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 58.321372, longitude: 15.268350, size: .small),
        
        Place(name: "Scary road", difficulty: .easy, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 30.321372, longitude: 17.268350, size: .small),
        Place(name: "Magic Forest", difficulty: .hard, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 67.321372, longitude: 19.268350, size: .small),
        
        Place(name: "Dummy Forest", difficulty: .medium, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 58.321372, longitude: 15.268350, size: .small),
        
        Place(name: "Scary road", difficulty: .easy, hint: "Behind the tree", description: "Enjoy your trip and prizees in this beautiful forest", latitude: 30.321372, longitude: 17.268350, size: .small)
    ]
    
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
        return self.place.difficulty.rawValue
    }
    
    var difficultyColor: UIColor {
        switch difficulty {
        case "Easy":
            return .systemGreen
        case "Medium":
            return .systemYellow
        case "Hard":
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
        return self.place.size.rawValue
    }
    

    
    var distanceValue: Int {
        let placeCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        let userCoordinate = CLLocation(latitude: PersistanceManager.shared.latitude, longitude: PersistanceManager.shared.longitude)
        
        let result = Int(placeCoordinate.distance(from: userCoordinate))
        
        return result
    }
    
    var distance: String {
        
        let placeCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        let userCoordinate = CLLocation(latitude: PersistanceManager.shared.latitude, longitude: PersistanceManager.shared.longitude)
        
        let result = Int(placeCoordinate.distance(from: userCoordinate))
        
        if result > 1000 {
            let resultAsKm = Double(result)/1000
            let resultString = String(format: "%.1f", resultAsKm)
            return "Distance: \(resultString) km"
        }
        
        return "Distance: \(result) m"
        
    }
    
}
