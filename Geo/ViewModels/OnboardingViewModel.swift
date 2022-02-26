//
//  OnboardingViewModel.swift
//  Geo
//
//  Created by Damian Durzyński on 26/02/2022.
//

import Foundation

//MARK: - List

struct OnboardingSlideListViewModel {
    let slides: [OnboardingSlide]
}

extension OnboardingSlideListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.slides.count
    }
    
    func slideAtIndex(_ index: Int) -> OnboardingSlideViewModel {
     
        let slide = self.slides[index]
        return OnboardingSlideViewModel(slide)
    }
}

//MARK: - Single Element

struct OnboardingSlideViewModel {
    
    private let slide: OnboardingSlide
    
}

extension OnboardingSlideViewModel {
    
    init(_ slide: OnboardingSlide) {
        self.slide = slide
    }
    
    var animationName: String {
        return self.slide.animationName
    }
    
    var title: String {
        return self.slide.title
    }
    
}
