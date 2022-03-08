//
//  MapViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 08/03/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private var placesListViewModel = PlaceListViewModel()
    
    //MARK: - UI Elements
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        
        return map
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()

        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.mapView.reloadInputViews()
        }
    }
}

//MARK: - Configure UI

extension MapViewController {
    private func setup() {

        title = "Map"
        
        view.addSubview(mapView)
        
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: mapView.bottomAnchor, multiplier: 0),
            
        ])
    }
}

//MARK: - Fetch Places

extension MapViewController {
    
    func fetchData() {
        
        DatabaseManager.shared.fetchPlaces { [weak self] places in

            if let places = places {
                self?.placesListViewModel.places = places
                self?.setupMapView()
                DispatchQueue.main.async {
      
                    self?.mapView.reloadInputViews()
                }
            }
        }
    }
    
}

//MARK: - MapView Delegate

extension MapViewController: MKMapViewDelegate {
 
    func setupMapView() {
        mapView.delegate = self
                         
        let lat = PersistanceManager.shared.latitude
        let long = PersistanceManager.shared.longitude
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let places = placesListViewModel.places
        
        var index = 0
        
        for _ in places {
 
            
            let annotation = MKPointAnnotation()
            
            let model = placesListViewModel.placeAtIndex(index)
            
            annotation.title = model.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        
            index += 1
            
            mapView.addAnnotation(annotation)
        }
        
    }

}
