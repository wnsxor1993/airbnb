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

        init(imageData: Data, title: String, description: String, buttonTitle: String) {
            self.imageData = imageData
            self.title = title
            self.description = description
            self.buttonTitle = buttonTitle
        }

        init() {
            imageData = Data()
            title = ""
            description = ""
            buttonTitle = ""
        }
    }

    struct AroundSpotData {
        let imageData: Data
        let title: String
        let distance: Int
    }

    struct ThemeSpotData {
        let imageData: Data
        let title: String
    }
}
