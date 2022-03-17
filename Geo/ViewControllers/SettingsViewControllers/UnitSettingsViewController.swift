//
//  UnitSettingsViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 16/03/2022.
//


import Foundation
import UIKit


class UnitSettingsViewController: UIViewController {
    
    private let unitSettingsListViewModel = UnitSettingsListViewModel()
    
    //MARK: - UI Elements
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: K.UnitSettingsVC.unitCellID)
        
        
        return table
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layoutUI()
        setupTableView()
    }
}

//MARK: - Configure UI

extension UnitSettingsViewController {
    private func setupUI() {
        
        title = K.UnitSettingsVC.title
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
    }
    
    private func layoutUI() {
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0),
            
        ])
    }
}

//MARK: - UITableViewDelegate & DataSource

extension UnitSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitSettingsListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.UnitSettingsVC.unitCellID, for: indexPath)
        
        let viewModel = unitSettingsListViewModel.unitAtIndex(indexPath.row)
        
        cell.textLabel?.text = viewModel.unit
        
        let selectedCell = unitSettingsListViewModel.selectedUnitIndex()
        
        if indexPath.row == selectedCell {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            PersistanceManager.shared.setupLengthUnit(unit: K.UserDefaultsKeys.meters)
        } else if indexPath.row == 1 {
            PersistanceManager.shared.setupLengthUnit(unit: K.UserDefaultsKeys.miles)
        } else {
            
        }
        
        let selectedCell = unitSettingsListViewModel.selectedUnitIndex()

        print(PersistanceManager.shared.lengthUnit)
        print(selectedCell)

        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
}




