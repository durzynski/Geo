//
//  HomeViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 03/03/2022.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private var userViewModel = UserViewModel()
    private var placesListViewModel = PlaceListViewModel()
    
    var locationManager = CLLocationManager()
    //MARK: - UI Elements
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        
        return stackView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(ofSize: 20, weight: .regular)
        label.textColor = .label
        
        return label
    }()
    
    private let exploreLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Explore places near you!"
        
        return label
    }()
    
    private let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlacesTableViewCell.self, forCellReuseIdentifier: PlacesTableViewCell.identifier)
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layoutUI()
        
        setupTableView()
        getUserLocation()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            
            DispatchQueue.main.async {
                self.placesTableView.reloadData()
            }
        }
        
    }
    
}

//MARK: - Configure UI

extension HomeViewController {
    
    func setupUI() {
        
        welcomeLabel.text = "Welcome \(userViewModel.name)"
        
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(welcomeLabel)
        labelStackView.addArrangedSubview(exploreLabel)
        
        view.addSubview(placesTableView)
        
    }
    
    func layoutUI() {
        
        
        NSLayoutConstraint.activate([
            
            labelStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            labelStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            placesTableView.topAnchor.constraint(equalToSystemSpacingBelow: labelStackView.bottomAnchor, multiplier: 2),
            placesTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: placesTableView.trailingAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: placesTableView.bottomAnchor, multiplier: 0)
            
        ])
        
    }
    
}

//MARK: - Actions

extension HomeViewController {
    
}

//MARK: - UITableView Delegate & DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        placesTableView.delegate = self
        placesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifier, for: indexPath) as? PlacesTableViewCell else {
            fatalError()
        }

        
        let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row, maxLength: 5)
        
        cell.configure(with: viewModel)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlacesTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row)

        let vc = PlaceDetailViewController(viewModel: viewModel)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
}

//MARK: - CLLocationManager Delegate

extension HomeViewController: CLLocationManagerDelegate {
    
    func getUserLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() 
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        PersistanceManager.shared.saveUserLocation(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
