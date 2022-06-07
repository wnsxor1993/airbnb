//
//  CountAccomodationsCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class CountAccomodationsCell: UICollectionViewCell {

    static let identifier = "CountAccomodationsCell"

    private let countAccomodationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .init(rawValue: 400))
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(countAccomodationsLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(countAccomodations: Int) {
        countAccomodationsLabel.text = "\(countAccomodations)개의 숙소"
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            countAccomodationsLabel.topAnchor.constraint(equalTo: topAnchor),
            countAccomodationsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countAccomodationsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countAccomodationsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
