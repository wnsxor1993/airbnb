//
//  DateData.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import Foundation

struct DateData {
    let startDate: Date
    let endDate: Date
    var description: String {
        return "\(startDate.toString()) - \(endDate.toString())"
    }

    init(dateRange: ClosedRange<Date>) {
        let dateComponents = dateRange.description
            .components(separatedBy: [".", " ", "+", "-"])
            .filter {!$0.isEmpty}
            .compactMap { Int($0) }
        let dates = Self.getDates(from: dateComponents)
        startDate = dates[0]
        endDate = dates[1]
    }

    private static func getDates(from dateComponents: [Int]) -> [Date] {
        return [
            "\(dateComponents[0])-\(dateComponents[1])-\(dateComponents[2])".toDate(),
            "\(dateComponents[4])-\(dateComponents[5])-\(dateComponents[6])".toDate()
        ]
    }
}
