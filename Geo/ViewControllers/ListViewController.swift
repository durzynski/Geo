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
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: K.ListVC.refreshControlText)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
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
            self.listTableView.reloadData()
            self.fetchData()
        }
    }
}

//MARK: - Configure UI

extension ListViewController {
    private func setup() {
        
        title = K.ListVC.title
        
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
}

//MARK: - Fetch Places

extension ListViewController {
    
    func fetchData() {
        
        FirebaseManager.shared.fetchPlaces { [weak self] places in

            if let places = places {
                self?.placesListViewModel.places = places
                
                DispatchQueue.main.async {
                    self?.listTableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
}

//MARK: - Actions

extension ListViewController {
    
    @objc func refresh() {
        fetchData()
    }
    
}


//MARK: - TableView Delegate & DataSource

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        listTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.identifier)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return K.ListVC.allPlacesSectionHeaderText
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
        
        let viewModel = placesListViewModel.sortedPlaceAtIndex(indexPath.row)
        
        cell.configure(with: viewModel)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if placesListViewModel.places.count == 0 {
            return listTableView.frame.size.height
        }
        
        return PlacesTableViewCell.preferredHeight
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
