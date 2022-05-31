//
//  DateConverter.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import Foundation

struct DateConverter {
    let startDate: Date
    let endDate: Date
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        dateFormatter.timeZone = .autoupdatingCurrent
        return "\(dateFormatter.string(from: startDate)) - \(dateFormatter.string(from: endDate))"
    }

    init(dateRange: ClosedRange<Date>) {
        startDate = dateRange.lowerBound
        endDate = dateRange.upperBound
    }
}
