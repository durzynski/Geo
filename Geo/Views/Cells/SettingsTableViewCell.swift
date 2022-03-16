//
//  SettingsTableViewCell.swift
//  Geo
//
//  Created by Damian Durzyński on 09/03/2022.
//

import Foundation
import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    static let prefferedHeight = CGFloat(45)
    
    //MARK: - UI Elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let cellIconContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let cellImageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupUI()
        layoutUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

//MARK: - Configure UI

extension SettingsTableViewCell {
    
    private func setupUI() {
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(cellIconContainer)
        cellIconContainer.addSubview(cellImageIcon)
        stackView.addArrangedSubview(cellLabel)
        
        accessoryType = .disclosureIndicator
        contentView.clipsToBounds = true
        backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI() {
        
        NSLayoutConstraint.activate([
          
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 0),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            
            cellImageIcon.centerXAnchor.constraint(equalTo: cellIconContainer.centerXAnchor),
            cellImageIcon.centerYAnchor.constraint(equalTo: cellIconContainer.centerYAnchor),

            cellIconContainer.heightAnchor.constraint(equalToConstant: 30),
            cellIconContainer.widthAnchor.constraint(equalTo: cellIconContainer.heightAnchor)
        ])
        
    }
    
}

//MARK: - Configure

extension SettingsTableViewCell {
    
    public func configure(viewModel: SettingsOptionViewModel) {
        cellImageIcon.image = viewModel.icon
        cellIconContainer.backgroundColor = viewModel.iconBackgroundColor
        cellLabel.text = viewModel.title
    }
}
