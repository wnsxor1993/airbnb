//
//  AroundSpotCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/24.
//

import UIKit

final class AroundSpotCell: UICollectionViewCell {

    static let identifier = "AroundSpotCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray1
        label.font = .systemFont(ofSize: 17, weight: .init(rawValue: 600))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray3
        label.font = .systemFont(ofSize: 17, weight: .init(rawValue: 400))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(imageData: Data, title: String, time: Int) {
        imageView.image = UIImage(data: imageData)
        titleLabel.text = title
        distanceLabel.text = "차로 \(time)분 거리"
    }
}

private extension AroundSpotCell {

    func setLayout() {
        addSubViews(imageView, titleLabel, distanceLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1/2)
        ])

        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
}
