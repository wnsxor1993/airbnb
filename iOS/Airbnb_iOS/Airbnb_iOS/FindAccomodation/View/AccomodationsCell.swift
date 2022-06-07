//
//  AccomodationsCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class AccomodationsCell: UICollectionViewCell {

    static let identifier = "AccomodationsCell"

    private let accomodationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layoutMargins = UIEdgeInsets(top: 19, left: 0, bottom: 0, right: 17.5)
        return imageView
    }()

    private let gradeAndCountReviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .init(rawValue: 400))
        label.textColor = .gray1
        return label
    }()

    private let countReviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .init(rawValue: 400))
        label.textColor = .gray3
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .init(rawValue: 400))
        label.textColor = .gray1
        return label
    }()

    private let pricePerDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .init(rawValue: 400))
        label.textColor = .gray1
        return label
    }()

    private let finalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .init(rawValue: 400))
        label.textColor = .gray3
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(accomodationImageView, gradeAndCountReviewStackView, nameLabel, pricePerDayLabel, finalPriceLabel)
        gradeAndCountReviewStackView.addArrangedSubview(gradeLabel)
        gradeAndCountReviewStackView.addArrangedSubview(countReviewLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(imageData: Data, grade: Double, countReview: Int, name: String, pricePerDay: Int, finalPrice: Int) {
        accomodationImageView.image = UIImage(data: imageData)
        gradeLabel.text = String(grade)
        countReviewLabel.text = "(후기 \(countReview)개)"
        pricePerDayLabel.text = "₩\(pricePerDay.toKRW()) / 박"
        finalPriceLabel.attributedText = "총 ₩\(finalPrice.toKRW())".underLine()
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            accomodationImageView.topAnchor.constraint(equalTo: topAnchor),
            accomodationImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            accomodationImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            accomodationImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.67),

            gradeAndCountReviewStackView.topAnchor.constraint(equalTo: accomodationImageView.bottomAnchor, constant: 9),
            gradeAndCountReviewStackView.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor),
            gradeAndCountReviewStackView.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor),
            gradeAndCountReviewStackView.heightAnchor.constraint(equalToConstant: 18),

            nameLabel.topAnchor.constraint(equalTo: gradeAndCountReviewStackView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),

            pricePerDayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            pricePerDayLabel.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor),
            pricePerDayLabel.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor),
            pricePerDayLabel.heightAnchor.constraint(equalToConstant: 22),

            finalPriceLabel.topAnchor.constraint(equalTo: pricePerDayLabel.bottomAnchor, constant: 8),
            finalPriceLabel.leadingAnchor.constraint(equalTo: accomodationImageView.leadingAnchor),
            finalPriceLabel.trailingAnchor.constraint(equalTo: accomodationImageView.trailingAnchor),
            finalPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
