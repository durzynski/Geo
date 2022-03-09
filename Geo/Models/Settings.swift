//
//  Settings.swift
//  Geo
//
//  Created by Damian Durzyński on 09/03/2022.
//

import Foundation
import UIKit

struct SettingsSection {
    
    let title: String
    let options: [SettingsOption]
    
}

struct SettingsOption {
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

