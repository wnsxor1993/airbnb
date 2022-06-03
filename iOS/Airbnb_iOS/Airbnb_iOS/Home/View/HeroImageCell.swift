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
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .init(rawValue: 400))
        label.textColor = UIColor.gray1
        label.numberOfLines = 0
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
            titleLabel.heightAnchor.constraint(equalToConstant: 82),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 44),

            heroButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            heroButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            heroButton.layoutMarginsGuide.heightAnchor.constraint(equalToConstant: 38),
            heroButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 165),
            heroButton.widthAnchor.constraint(lessThanOrEqualTo: imageView.widthAnchor)
        ])
    }

    func configure(imageData: Data, title: String, description: String, buttonTitle: String) {
        let heroImage = UIImage(data: imageData) ?? UIImage()
        imageView.image = heroImage
        titleLabel.text = title
        descriptionLabel.text = description
        heroButton.setTitle(buttonTitle, for: .normal)

        setAdditionalConstraint(imageSize: heroImage.size, titleText: title, descriptionText: description, buttonTitleText: buttonTitle)
    }
}

private extension HeroImageCell {
    func setAdditionalConstraint(imageSize: CGSize, titleText: String, descriptionText: String, buttonTitleText: String) {
        let imageRatio = imageSize.height / imageSize.width
        let imageViewNewWidth = safeAreaLayoutGuide.layoutFrame.width
        let imageViewNewHeight = imageViewNewWidth * imageRatio

        let titleLabelNewHeight = String.calculateLabelHeight(targetString: titleText, fontSize: titleLabel.font.pointSize, weight: titleLabel.font.weight)

        let descriptionLabelNewHeight = String.calculateLabelHeight(targetString: descriptionText, fontSize: descriptionLabel.font.pointSize, weight: descriptionLabel.font.weight)

        let heroButtonNewHeight = String.calculateLabelHeight(targetString: buttonTitleText, fontSize: heroButton.titleLabel?.font.pointSize ?? 0, weight: heroButton.titleLabel?.font.weight ?? .regular)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: imageViewNewHeight),

            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleLabelNewHeight),
            titleLabel.heightAnchor.constraint(lessThanOrEqualTo: imageView.heightAnchor, multiplier: 1/3),

            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: descriptionLabelNewHeight),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualTo: imageView.heightAnchor, multiplier: 1/3),

            heroButton.layoutMarginsGuide.heightAnchor.constraint(equalToConstant: heroButtonNewHeight)
        ])
    }
}
