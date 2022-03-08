//
//  ListViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 08/03/2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private var placesListViewModel = PlaceListViewModel()
    
    //MARK: - UI Elements
    
    private let listTableView: UITableView = {
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
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
}

//MARK: - Configure UI

extension ListViewController {
    private func setup() {
        
        title = "List"
        
        view.addSubview(listTableView)

    }
    
    private func layout() {

        NSLayoutConstraint.activate([

            listTableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            listTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: listTableView.trailingAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: listTableView.bottomAnchor, multiplier: 0),
            
        ])
    }
    
    private func configureNavigation() {
        
    }
}

//MARK: - Fetch Places

extension ListViewController {
    
    func fetchData() {
        
        DatabaseManager.shared.fetchPlaces { [weak self] places in

            if let places = places {
                self?.placesListViewModel.places = places
                
                DispatchQueue.main.async {
                    self?.listTableView.reloadData()
                }
            }
        }
    }
    
}



//MARK: - TableView Delegate & DataSource

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All places"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifier, for: indexPath) as? PlacesTableViewCell else {
            fatalError()
        }
        
        let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row)
        
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
