//
//  OnboardingCollectionViewCell.swift
//  Geo
//
//  Created by Damian Durzyński on 26/02/2022.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    //MARK: - UI
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.contentMode = .scaleAspectFill
        stackView.alignment = .center
        return stackView
    }()
    
    private let animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
                
        return animationView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to Geo!"
        
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension OnboardingCollectionViewCell {
    func setup() {
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(titleLabel)
        
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        
    }
    
    func configure(with viewModel: OnboardingSlideViewModel) {
        
        animationView.animation = Animation.named(viewModel.animationName)
        titleLabel.text = viewModel.title

        if !animationView.isAnimationPlaying {
            animationView.play()
        }
        
        
        
    }
}
