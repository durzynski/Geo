//
//  Place.swift
//  Geo
//
//  Created by Damian Durzyński on 03/03/2022.
//

import Foundation

struct Place {
    let name: String
    let difficulty: Difficulty
    let hint: String
    let description: String
    let latitude: Double
    let longitude: Double
    let size: Size
    
    enum Difficulty: String {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }
    
    enum Size: String {
        case small = "Small"
        case medium = "Medium"
        case big = "Big"
    }
}
