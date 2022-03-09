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
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.identifier)
        
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layoutUI()
        
        setupTableView()
        
        fetchData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeLabel.text = "Welcome \(userViewModel.name)"
        
        DispatchQueue.main.async { [weak self] in
            self?.placesTableView.reloadData()
        }
    }
}

//MARK: - Configure UI

extension HomeViewController {
    
    func setupUI() {
        
        
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

//MARK: - Fetch Places

extension HomeViewController {
    
    func fetchData() {
        
        DatabaseManager.shared.fetchPlaces { [weak self] places in

            if let places = places {
                self?.placesListViewModel.places = places
                
                DispatchQueue.main.async {
                    self?.placesTableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
}

//MARK: - Actions

extension HomeViewController {
    
    @objc func refresh() {
        
        fetchData()
        
    }
    
}

//MARK: - UITableView Delegate & DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        placesTableView.addSubview(refreshControl)
        placesTableView.delegate = self
        placesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if placesListViewModel.places.count == 0 {
            return 1
        }
        
        return placesListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if placesListViewModel.places.count == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell else {
                fatalError()
            }
            
            return cell
            
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifier, for: indexPath) as? PlacesTableViewCell else {
            fatalError()
        }

        
        let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row, maxLength: 5)
        
        cell.configure(with: viewModel)
        
        if CLLocationManager.locationServicesEnabled() {
            cell.distanceLabel.isHidden = false
        } else {
            cell.distanceLabel.isHidden = true
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if placesListViewModel.places.count == 0 {
            return placesTableView.frame.size.height 
        }
        
        return PlacesTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if placesListViewModel.places.count != 0 {
            
            let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row)

            let vc = PlaceDetailViewController(viewModel: viewModel)
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            
            present(navVC, animated: true)
        }
        
    }
}

