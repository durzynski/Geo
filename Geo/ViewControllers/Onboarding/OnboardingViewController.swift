//
//  OnboardingViewController.swift
//  Geo
//
//  Created by Damian Durzyński on 26/02/2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    private var index: Int = 0
    private var slidesListViewModel: OnboardingSlideListViewModel!
    
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
        setupSlides()
    }
    
    func setupSlides() {
        
        let slides: [OnboardingSlide] = [
            OnboardingSlide(animationName: "box-floating", title: "Screen number 1"),
            OnboardingSlide(animationName: "box-floating", title: "Screen 2"),
            OnboardingSlide(animationName: "box-floating", title: "Screen 3"),
        ]
        
        self.slidesListViewModel = OnboardingSlideListViewModel(slides: slides)
        
        self.pageControl.numberOfPages = slides.count
    }
    
}

//MARK: - Style & Layout UI

extension OnboardingViewController {
    
    func style() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
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
        
        self.index += 1
        
        if index <= slidesCount {
            
            pageControl.currentPage = index
            
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(
                at: IndexPath(item: index, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
            collectionView.isPagingEnabled = true
            
            if index == slidesCount {
                nextButton.setTitle("Get Started", for: [])
            }
        }

        
        if index > slidesCount {
            let vc = ViewController()
            
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
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
