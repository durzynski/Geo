//
//  UnitSettingsViewModel.swift
//  Geo
//
//  Created by Damian Durzyński on 16/03/2022.
//

import Foundation

struct UnitSettingsListViewModel {
    
    var units: [String] = ["Kilometers", "Miles"]
}

extension UnitSettingsListViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.units.count
    }
    
    func unitAtIndex(_ index: Int) -> UnitSettingsViewModel {
     
        let unit = self.units[index]
        return UnitSettingsViewModel(unit)
    }
    
    func selectedUnitIndex() -> Int {
        
        let unit = PersistanceManager.shared.lengthUnit
        
        if unit == "Meters" {
            return 0
        } else {
            return 1
        }
        
    }
}

struct UnitSettingsViewModel {
    
    let unit: String
    
}

extension UnitSettingsViewModel {
    
    init(_ unit: String) {
        self.unit = unit
    }
}
