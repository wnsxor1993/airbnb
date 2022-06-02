//
//  AccomodationData.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/02.
//

import Foundation

enum AccomodationData {
    case location(Location)
    case accomodationPeriod(Period)
    case budget(price: Int?)
    case headCount(Persons)

    var title: String {
        switch self {
        case .location:
            return "위치"
        case .accomodationPeriod:
            return "체크인/체크아웃"
        case .budget:
            return "요금"
        case .headCount:
            return "인원"
        }
    }

    var data: String? {
        switch self {
        case .location(let location):
            return location.name
        case .accomodationPeriod(let period):
            guard let period = period.dateRange else {
                return nil
            }
            return DateConverter.convertToDateRangeString(dateRange: period)
        case .budget(let price):
            if let price = price {
                return "\(price)"
            }
            return nil
            // ~,~ 원 단위로 변환하는 로직 필요
        case .headCount(let persons):
            var headCount = 0
            var nullCount = 3
            if let adult = persons.adults {
                headCount += adult
                nullCount -= 1
            }
            if let children = persons.children {
                headCount += children
                nullCount -= 1
            }
            if let toddlers = persons.toddlers {
                headCount += toddlers
                nullCount -= 1
            }
            return nullCount == 3 ? nil : "\(headCount)"
        }
    }

    struct Location {
        var name: String?
        var latitude: Double?
        var longitude: Double?
    }

    struct Period {
        var dateRange: ClosedRange<Date>?
    }

    struct Persons {
        var adults: Int?
        var children: Int?
        var toddlers: Int?
    }
}
