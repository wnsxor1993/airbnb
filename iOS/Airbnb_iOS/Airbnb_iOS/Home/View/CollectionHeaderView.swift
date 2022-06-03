//
//  CollectionHeaderView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/24.
//

import UIKit

final class CollectionHeaderView: UICollectionReusableView {

    static let identifier = "HeaderView"

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setHeaderText(text: nil)
    }

    func setHeaderText(text: String?) {
        label.text = text
    }

    func setHeaderFontSize(size: CGFloat) {
        label.font = .systemFont(ofSize: size, weight: .init(rawValue: 400))
    }
}

private extension CollectionHeaderView {

    func setLayout() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }
}
