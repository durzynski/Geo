//
//  PlaceDetailViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 04/03/2022.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    
    private let viewModel: PlaceViewModel?
    
    //MARK: - Init
    
    init(viewModel: PlaceViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel!)
        
    }
    
}
