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
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMarkerAnnotationView.self.description())
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
        

        
        if !PersistanceManager.shared.locationEnabled {
            var defaultRegion: MKCoordinateRegion?
            defaultRegion = mapView.region
            
            if let region = defaultRegion {
                mapView.setRegion(region, animated: true)
            }
        } else {
            let lat = PersistanceManager.shared.latitude
            let long = PersistanceManager.shared.longitude
            
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            
            let region = MKCoordinateRegion(center: location, span: span)
            
            mapView.setRegion(region, animated: true)
        }

        let places = placesListViewModel.places
        
        var index = 0
        
        for _ in places {
 
            
            let annotation = PlaceMapAnnotation()
            
            let model = placesListViewModel.placeAtIndex(index)
            
            annotation.title = model.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
            annotation.place = model
            annotation.color = model.difficultyColor
            
            index += 1
            
            mapView.addAnnotation(annotation)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseIdentifier = "PlaceAnnotationView"
        
        var placeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if placeAnnotationView == nil {
            
            placeAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            placeAnnotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            placeAnnotationView?.rightCalloutAccessoryView = btn
            
        } else {
            placeAnnotationView?.annotation = annotation
        }
        
        if let placeAnnotation = annotation as? PlaceMapAnnotation {
            placeAnnotationView?.set(image: UIImage(systemName: "mappin.circle.fill") ?? UIImage(), with: placeAnnotation.color ?? UIColor.black)
            placeAnnotationView?.frame.size = CGSize(width: 40, height: 40)
        }
        
        return placeAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let placeAnnotationView = view.annotation as? PlaceMapAnnotation,
              let place = placeAnnotationView.place else {
            return
        }
        
        let vc = PlaceDetailViewController(viewModel: place)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
        
    }

}
