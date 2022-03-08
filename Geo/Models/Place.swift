//
//  Place.swift
//  Geo
//
//  Created by Damian Durzyński on 03/03/2022.
//

import Foundation

struct Place: Codable {
    
    let name: String
    let difficulty: String
    let hint: String
    let description: String
    let latitude: Double
    let longitude: Double
    let size: String

}
