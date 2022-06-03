//
//  String+.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import UIKit

extension String {

    func strikeThrough() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        attributedString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(0..<attributedString.length))

        return attributedString
    }

    static func calculateLabelHeight(targetString: String = "년월", fontSize: CGFloat, weight: UIFont.Weight) -> CGFloat {
        let textForCalculatingHeight = NSString(string: targetString)
        let fittedHeight = textForCalculatingHeight
            .size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: weight)])
            .height

        return fittedHeight
    }
}
