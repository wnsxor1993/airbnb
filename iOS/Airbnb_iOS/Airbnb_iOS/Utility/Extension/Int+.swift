//
//  Int+.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation

extension Int {
    func toKRW() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let price = numberFormatter.string(from: self as NSNumber) ?? ""
        return "\(price)원"
    }

    func toKM() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let distanceInKm = numberFormatter.string(from: self as NSNumber) ?? ""
        return "\(distanceInKm) km"
    }
}
