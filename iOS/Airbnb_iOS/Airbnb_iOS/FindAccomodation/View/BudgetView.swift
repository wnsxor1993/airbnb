//
//  BudgetView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit

final class BudgetView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
