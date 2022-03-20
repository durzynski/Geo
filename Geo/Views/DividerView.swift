//
//  DividerView.swift
//  Geo
//
//  Created by Damian Durzyński on 17/03/2022.
//

import Foundation
import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
