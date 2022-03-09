//
//  SlideViewModel.swift
//  Geo
//
//  Created by Damian Durzyński on 26/02/2022.
//

import Foundation

//MARK: - List

struct SlideListViewModel {
    
    let slides: [Slide] = [
        Slide(animationName: "world", title: "Explore the world."),
        Slide(animationName: "mapa", title: "Discover amazing places."),
        Slide(animationName: "box-empty", title: "Find unforgettable things!"),
    ]
}

extension SlideListViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.slides.count
    }
    
    func slideAtIndex(_ index: Int) -> SlideViewModel {
     
        let slide = self.slides[index]
        return SlideViewModel(slide)
    }
    
    func numberOfPages() -> Int {
        return self.slides.count
    }
}

//MARK: - Single Element

struct SlideViewModel {
    
    private let slide: Slide
    
}

extension SlideViewModel {
    
    init(_ slide: Slide) {
        self.slide = slide
    }
    
    var animationName: String {
        return self.slide.animationName
    }
    
    var title: String {
        return self.slide.title
    }
    
}
