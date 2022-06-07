//
//  HeroImageCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/24.
//

import UIKit

final class HeroImageCell: UICollectionViewCell {

    static let identifier = "HeroImageCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 0)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 34, weight: .init(rawValue: 500))
        label.numberOfLines = 2
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .init(rawValue: 400))
        label.textColor = UIColor.gray1
        label.numberOfLines = 2
        return label
    }()

    private let heroButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.gray1
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .init(rawValue: 400))
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(imageView, titleLabel, descriptionLabel, heroButton)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.topAnchor),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: String.calculateLabelHeight(targetString: "슬기로운\n자연생활", fontSize: 34, weight: .init(rawValue: 500))),
            titleLabel.heightAnchor.constraint(lessThanOrEqualTo: imageView.heightAnchor, multiplier: 1/3),
            titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/2),

            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/2),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: String.calculateLabelHeight(targetString: "에어비앤비가 엄선한\n위시리스트를 만나보세요.", fontSize: 17, weight: .init(rawValue: 400))),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualTo: titleLabel.heightAnchor),

            heroButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            heroButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            heroButton.layoutMarginsGuide.heightAnchor.constraint(equalToConstant: String.calculateLabelHeight(targetString: "여행아이디어", fontSize: 17, weight: .init(rawValue: 400))),
            heroButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 165),
            heroButton.widthAnchor.constraint(lessThanOrEqualTo: imageView.widthAnchor)
        ])
    }

    func configure(imageData: Data, title: String, description: String, buttonTitle: String) {
        imageView.image = UIImage(data: imageData)
        titleLabel.text = title
        descriptionLabel.text = description
        heroButton.setTitle(buttonTitle, for: .normal)
    }
}
