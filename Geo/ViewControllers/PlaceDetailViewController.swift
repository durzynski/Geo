//
//  PlaceDetailViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 04/03/2022.
//

import UIKit

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
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private let difficultySizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let difficultyView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView()
        return view
    }()
    
    private let sizeView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView()
        return view
    }()
    
    private let secondDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
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
    }
    
    func layoutUI() {
        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            mainStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStackView.trailingAnchor, multiplier: 1),
            
            difficultySizeStackView.heightAnchor.constraint(equalToConstant: 75),
            
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            secondDividerView.heightAnchor.constraint(equalToConstant: 2),
        ])
        
    }
}

//MARK: - Setup Navigation

extension PlaceDetailViewController {
    func setupNavigation() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        
    }
}

//MARK: - Configure with ViewModel

extension PlaceDetailViewController {
    
    private func configure(with viewModel: PlaceViewModel) {
        
        titleLabel.text = viewModel.name
        
        difficultyView.titleLabel.text = "Difficulty"
        difficultyView.subtitleLabel.text = viewModel.difficulty
        
        switch viewModel.difficulty {
        case "Easy":
            difficultyView.subtitleLabel.textColor = .systemGreen
        case "Medium":
            difficultyView.subtitleLabel.textColor = .systemYellow
        case "Hard":
            difficultyView.subtitleLabel.textColor = .systemRed
        default:
            break
        }
        
        sizeView.titleLabel.text = "Size"
        sizeView.subtitleLabel.text = viewModel.size
    }
    
}

//MARK: - Actions

extension PlaceDetailViewController {
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
