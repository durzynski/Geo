//
//  SavedPlacesListViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 17/03/2022.
//

import UIKit

class SavedPlacesListViewController: UIViewController {
    
    private var placesListViewModel = PlaceListViewModel()
    
    //MARK: - UI Elements
    
    private let savedListTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PlacesTableViewCell.self, forCellReuseIdentifier: PlacesTableViewCell.identifier)
        
        return table
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.fetchData()
            self.savedListTableView.reloadData()
        }
    }
}

//MARK: - Configure UI

extension SavedPlacesListViewController {
    private func setup() {
        
        title = "Saved places"
        
        view.backgroundColor = .systemBackground
        view.addSubview(savedListTableView)

    }
    
    private func layout() {

        NSLayoutConstraint.activate([

            savedListTableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            savedListTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: savedListTableView.trailingAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: savedListTableView.bottomAnchor, multiplier: 0),
            
        ])
    }
}

//MARK: - Fetch Data From CoreData

extension SavedPlacesListViewController {
    
    func fetchData() {
        
        placesListViewModel.savedPlaces = CoreDataManager.shared.fetchPlaces()

    }
    
}

//MARK: - TableView Delegate & DataSource

extension SavedPlacesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        savedListTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.identifier)
        savedListTableView.delegate = self
        savedListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if placesListViewModel.savedPlaces.count == 0 {
            return 1
        }
        
        return placesListViewModel.numberOfRowsInSectionCoreData(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if placesListViewModel.savedPlaces.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell else {
                fatalError()
            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifier, for: indexPath) as? PlacesTableViewCell else {
            fatalError()
        }
        
        let viewModel = placesListViewModel.placeAtIndexFromCoreData(indexPath.row)

        cell.configure(with: viewModel)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if placesListViewModel.savedPlaces.count == 0 {
            
            return savedListTableView.frame.size.height
        }
        
        return PlacesTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if placesListViewModel.savedPlaces.count != 0 {
            let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row)

            let vc = PlaceDetailViewController(viewModel: viewModel)
            let navVC = UINavigationController(rootViewController: vc)
            
            present(navVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let place = placesListViewModel.savedPlaces[indexPath.row]
            
            CoreDataManager.shared.deletePlace(place)
            
            DispatchQueue.main.async {
                self.fetchData()
                self.savedListTableView.reloadData()
            }
            
        }
        
    }
}

