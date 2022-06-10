//
//  AccomodationsViewComponentsData.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import Foundation

enum AccomodationsViewComponentsData {
    case accomodationOptionSection(OptionInfo?)
    case countAccomodationsSection(count: Int)
    case accomodationsSection([AccomodationInfo]?)

    struct OptionInfo {
        let locationName: String?
        let dateRange: ClosedRange<Date>?
    }

    struct AccomodationInfo {
        let id: Int
        let title: String
        let averageGrade, numberOfReviews: Int
        let imageData: Data
        let price: Int
    }
}
