//
//  PlacesTableViewCell.swift
//  Geo
//
//  Created by Damian Durzyński on 04/03/2022.
//

import Foundation
import UIKit
import MapKit

class PlacesTableViewCell: UITableViewCell {
    
    static let identifier = "PlacesTableViewCell"
    static let prefferedHeight = CGFloat(75)
    
    private let difficultyColorView: UIView = {
        let view =  UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.isHidden = true
        
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

//MARK: - Setup UI

extension PlacesTableViewCell {
    
    func setupUI() {
        
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(difficultyColorView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(placeNameLabel)
        labelStackView.addArrangedSubview(distanceLabel)
        
    }
    
    func layoutUI() {
        
        NSLayoutConstraint.activate([
            
            
            difficultyColorView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            difficultyColorView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 3),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: difficultyColorView.bottomAnchor, multiplier: 3),
            difficultyColorView.widthAnchor.constraint(equalTo: difficultyColorView.heightAnchor),
            
            labelStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: difficultyColorView.trailingAnchor, multiplier: 2),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
            
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius = difficultyColorView.frame.size.height / 2
        difficultyColorView.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        placeNameLabel.text = nil
        distanceLabel.text = nil
    }
    
}

//MARK: - Configure

extension PlacesTableViewCell {
    
    func configure(with viewModel: PlaceViewModel) {
        
        difficultyColorView.backgroundColor = viewModel.difficultyColor
        
        placeNameLabel.text = viewModel.name
        
        if PersistanceManager.shared.locationEnabled {
            distanceLabel.text = viewModel.distance
        }
        
        if PersistanceManager.shared.locationEnabled {
            distanceLabel.isHidden = false
        } else {
            distanceLabel.isHidden = true
        }
       
    }
    
}
