//
//  AccomodationOptionCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class AccomodationOptionCell: UICollectionViewCell {

    static let identifier = "AccomodationOptionCell"

    private let optionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .init(rawValue: 400))
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(optionsLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            optionsLabel.topAnchor.constraint(equalTo: topAnchor),
            optionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(location: String?, dateRange: String?) {
        var optionsText = ""
        if let location = location {
            optionsText += "\(location) ∙"
        }

        if let dateRange = dateRange {
            optionsText += "\(dateRange)"
        } else {
            _ = optionsText.removeLast()
        }

        optionsLabel.text = optionsText
    }
}
