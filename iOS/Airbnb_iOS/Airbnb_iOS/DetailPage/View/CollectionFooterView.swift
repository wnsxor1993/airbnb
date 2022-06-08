//
//  DetailPageCollectionFooter.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/07.
//

import UIKit

final class CollectionFooterView: UICollectionReusableView {

    static let identifier = "FooterView"

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray1
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension CollectionFooterView {

    func setLayout() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 1),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
