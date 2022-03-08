//
//  EmptyTableViewCell.swift
//  Geo
//
//  Created by Damian Durzyński on 08/03/2022.
//

import Foundation
import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    static let identifier = "EmptyTableViewCell"
    
    //MARK: - UI Elements
    
    private let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 48
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let emptyCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .tertiaryLabel
        imageView.image = UIImage(systemName: "questionmark.folder.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emptyCellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiaryLabel
        label.text = "No data. Pull to refresh to try again."
        
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        layoutUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setup UI

extension EmptyTableViewCell {
    
    private func setupUI() {
        
        contentView.addSubview(container)
        container.addSubview(stackView)
        stackView.addArrangedSubview(emptyCellImageView)
        stackView.addArrangedSubview(emptyCellLabel)
    }
    
    private func layoutUI() {
        
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 0),
            container.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: container.trailingAnchor, multiplier: 0),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: container.bottomAnchor, multiplier: 0),
            
            stackView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            emptyCellImageView.widthAnchor.constraint(equalToConstant: 125)
            
        ])
        
    }
    
}
