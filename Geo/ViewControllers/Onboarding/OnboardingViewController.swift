//
//  OnboardingViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 26/02/2022.
//

import UIKit

protocol OnboardingViewControllerDelegate {
    func didFinishOnboarding()
}

class OnboardingViewController: UIViewController {
    
    private var slideIndex: Int = 0
    private var slidesListViewModel = SlideListViewModel()
    
    var delegate: OnboardingViewControllerDelegate?
    
    //MARK: - UI Elements
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.layer.cornerRadius = 8
        collectionView.clipsToBounds = true
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemGreen
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPage = 0
        pageControl.backgroundColor = .systemBackground
        
        return pageControl
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.imagePadding = 8
        button.setTitle("Next", for: [])
        button.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.buttonSize = .large
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
        setupCollectionView()

    }
}

//MARK: - Style & Layout UI

extension OnboardingViewController {
    
    func style() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        self.pageControl.numberOfPages = slidesListViewModel.numberOfPages()
        
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow:  view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 2),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 2),
            
            nextButton.topAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 1),
            nextButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            
            
        ])
        
    }
    
}

//MARK: - Actions

extension OnboardingViewController {
    @objc func nextTapped() {
        
        let slidesCount = slidesListViewModel.slides.count - 1
        
        self.slideIndex += 1
        
        if slideIndex <= slidesCount {
            
            pageControl.currentPage = slideIndex
            
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(
                at: IndexPath(item: slideIndex, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
            collectionView.isPagingEnabled = true
            
            if slideIndex == slidesCount {
                nextButton.setTitle("Get Started", for: [])
            }
        }
        
        if slideIndex > slidesCount {
            
            delegate?.didFinishOnboarding()
        }
        
        
    }
}

//MARK: - CollectionView Delegate & DataSource

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidesListViewModel.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else {
            fatalError()
        }
        
        let viewModel = self.slidesListViewModel.slideAtIndex(indexPath.row)
        
        cell.configure(with: viewModel)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width
        
        return CGSize(width: width, height: height)
    }
    
}
