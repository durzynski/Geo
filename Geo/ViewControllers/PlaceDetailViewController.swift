//
//  PlaceDetailViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 04/03/2022.
//

import UIKit
import MapKit

class PlaceDetailViewController: UIViewController {
    
    private let viewModel: PlaceViewModel?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.contentMode = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rounded(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let dividerView = DividerView(frame: .zero)
    
    private let difficultySizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let difficultyView = TitleAndSubtitleView()
    
    private let sizeView = TitleAndSubtitleView()
    
    private let secondDividerView = DividerView(frame: .zero)
    
    private let hintView = TitleAndSubtitleView()
    
    private let thirdDividerView = DividerView(frame: .zero)

    private let descriptionView = TitleAndSubtitleView()
    
    //MARK: - Init
    
    init(viewModel: PlaceViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layoutUI()
        setupNavigation()
        
        guard let viewModel = viewModel else {
            return
        }
        
        configure(with: viewModel)
    }
    
}

//MARK: - Configure UI

extension PlaceDetailViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(dividerView)
        mainStackView.addArrangedSubview(difficultySizeStackView)
        difficultySizeStackView.addArrangedSubview(difficultyView)
        difficultySizeStackView.addArrangedSubview(sizeView)
        mainStackView.addArrangedSubview(secondDividerView)
        mainStackView.addArrangedSubview(hintView)
        mainStackView.addArrangedSubview(thirdDividerView)
        mainStackView.addArrangedSubview(descriptionView)
    }
    
    func layoutUI() {
        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            mainStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStackView.trailingAnchor, multiplier: 2),
            
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            secondDividerView.heightAnchor.constraint(equalToConstant: 2),
            thirdDividerView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
    }
}

//MARK: - Setup Navigation

extension PlaceDetailViewController {
    func setupNavigation() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
    }
}

//MARK: - Configure with ViewModel

extension PlaceDetailViewController {
    
    private func configure(with viewModel: PlaceViewModel) {
        
        titleLabel.text = viewModel.name
        
        difficultyView.titleLabel.text = K.PlaceDetailVC.difficulty
        difficultyView.subtitleLabel.text = viewModel.difficulty
        difficultyView.subtitleLabel.textColor = viewModel.difficultyColor
        
        sizeView.titleLabel.text = K.PlaceDetailVC.size
        sizeView.subtitleLabel.text = viewModel.size
        
        hintView.titleLabel.text = K.PlaceDetailVC.hint
        hintView.subtitleLabel.text = viewModel.hint
        
        descriptionView.titleLabel.text = K.PlaceDetailVC.description
        descriptionView.subtitleLabel.text = viewModel.description
    }
    
}

//MARK: - Actions

extension PlaceDetailViewController {
    
    @objc func saveTapped() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.save(with: viewModel)
        
        print(CoreDataManager.shared.fetchPlaces())
    }
    
}
