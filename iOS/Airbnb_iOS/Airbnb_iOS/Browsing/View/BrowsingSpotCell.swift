//
//  BrowsingSpotCell.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/26.
//

import UIKit

final class BrowsingSpotCell: UICollectionViewCell {

    static let identifier = "BrowsingSpotCell"

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configure(image: nil, title: nil)
    }

    func configure(image: UIImage?, title: String?) {
        imageView.image = image
        titleLabel.text = title
    }
}

private extension BrowsingSpotCell {

    func setLayout() {
        self.contentView.addSubViews(imageView, titleLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1/3)
        ])
    }
}
