//
//  HomeViewComponentsData.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation

enum HomeViewComponentsData {
    case firstSection(HeroImageData)
    case secondSection([AroundSpotData])
    case thirdSection([ThemeSpotData])

    struct HeroImageData {
        let imageData: Data
        let title: String
        let description: String
        let buttonTitle: String
    }

    struct AroundSpotData {
        let imageData: Data
        let title: String
        let distanceDescription: String
    }

    struct ThemeSpotData {
        let imageData: Data
        let title: String
    }
}
