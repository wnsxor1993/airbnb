//
//  LivingTravelCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/24.
//

import UIKit

final class LivingTravelCell: UICollectionViewCell {

    static let identifier = "LivingTravelCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1) // Gray1
        label.font = .systemFont(ofSize: 17, weight: .init(600))
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

    private func setLayout() {
        contentView.addSubViews([imageView, titleLabel])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16)
        ])
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

private extension UIView {
    func addSubViews(_ subViews: [UIView]) {
        subViews.forEach {
            self.addSubview($0)
        }
    }
}