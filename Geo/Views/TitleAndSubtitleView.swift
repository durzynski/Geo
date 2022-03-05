//
//  TitleAndSubtitleView.swift
//  Geo
//
//  Created by Damian Durzyński on 05/03/2022.
//

import UIKit

class TitleAndSubtitleView: UIView {
    
    //MARK: - UI Elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .medium)
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        styleUI()
        layoutUI()
        
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Configure UI

extension TitleAndSubtitleView {
    
    func styleUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
    }
    
    func layoutUI() {

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

