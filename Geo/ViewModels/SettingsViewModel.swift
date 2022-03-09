//
//  SettingsViewModel.swift
//  Geo
//
//  Created by Damian Durzyński on 09/03/2022.
//

import Foundation
import UIKit

//MARK: - List

struct SettingsSectionListViewModel {
    
    var sections: [SettingsSection] = []
}

extension SettingsSectionListViewModel {
    
    func headerForSection(_ section: Int) -> String? {
        return sections[section].title
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSections(_ section: Int) -> Int {
        return sections[section].options.count
    }
    
    func optionsAtIndex(section: Int, index: Int) -> SettingsOptionViewModel  {
        
        let options = self.sections[section].options[index]
        
        return SettingsOptionViewModel(options: options)
    }

}

//MARK: - Single Element

struct SettingsOptionViewModel {
    var options: SettingsOption
}

extension SettingsOptionViewModel {
    
    init(_ options: SettingsOption) {
        self.options = options
    }
 
    var title: String {
        return self.options.title
    }
    
    var icon: UIImage {
        return self.options.icon
    }
    
    var iconBackgroundColor: UIColor {
        return self.options.iconBackgroundColor
    }
    
    var handler: () -> Void {
        
        return self.options.handler
    }
    
}
