//
//  String+.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import UIKit

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }

    func strikeThrough() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        attributedString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(0..<attributedString.length))

        return attributedString
    }
}
