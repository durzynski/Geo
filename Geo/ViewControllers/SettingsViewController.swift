//
//  SettingsViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 03/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var settingsListViewModel = SettingsSectionListViewModel()
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        layoutUI()
        configureTableView()
        configureViewModel()
    }
}


extension SettingsViewController {
    func styleUI() {
        title = "Settings"
        
        view.addSubview(tableView)
    }
    
    func layoutUI() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0)
        ])
        
    }
    
    private func configureViewModel() {
        
        settingsListViewModel.sections =  [
            
            SettingsSection(title: "Preferences", options: [
                
                SettingsOption(title: "First", icon: UIImage(systemName: "") ?? UIImage(), iconBackgroundColor: .systemBlue, handler: {
                    print("First")
                }),
                
                SettingsOption(title: "Second", icon: UIImage(systemName: "") ?? UIImage(), iconBackgroundColor: .systemGreen, handler: {
                    print("Second")
                }),
                
            ]),
            
            SettingsSection(title: "User", options: [
                
                SettingsOption(title: "Sign out", icon: UIImage(systemName: "person.fill") ?? UIImage(), iconBackgroundColor: .systemRed, handler: { [weak self] in
                    
                    let vc = SignOutViewController()
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                }),
                
            ]),
        ]
        
    }
}

//MARK: - Tableview Delegate & Datasource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsListViewModel.headerForSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsListViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsListViewModel.numberOfRowsInSections(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError()
        }
        
        let viewModel = settingsListViewModel.optionsAtIndex(section: indexPath.section, index: indexPath.row)
        
        cell.configure(viewModel: viewModel)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModel = settingsListViewModel.optionsAtIndex(section: indexPath.section, index: indexPath.row)
        
        viewModel.handler()
        
    }
}
