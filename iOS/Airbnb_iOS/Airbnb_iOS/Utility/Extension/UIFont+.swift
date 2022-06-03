//
//  UIFont+.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import UIKit

extension UIFont {
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else {return .regular}
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }

    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any] ?? [:]
    }
}
