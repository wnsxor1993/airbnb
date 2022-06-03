//
//  DateConverter.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import Foundation

struct DateConverter {
    static private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter
    }()

    static func convertToDateRangeString(dateRange: ClosedRange<Date>) -> String {
        dateFormatter.dateFormat = "M월 d일"
        return "\(dateFormatter.string(from: dateRange.lowerBound)) - \(dateFormatter.string(from: dateRange.upperBound))"
    }

    static func convertToYearAndMonthString(date: Date) -> String {
        dateFormatter.dateFormat = "y년 M월"
        return dateFormatter.string(from: date)
    }

    static func convertToDayString(date: Date) -> String {
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
}
