//
//  AccomodationsView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class AccomodationsView: UIView {

    private lazy var accomodationsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true

        collectionView.register(AccomodationOptionCell.self, forCellWithReuseIdentifier: AccomodationOptionCell.identifier)
        collectionView.register(CountAccomodationsCell.self, forCellWithReuseIdentifier: CountAccomodationsCell.identifier)
        collectionView.register(AccomodationsCell.self, forCellWithReuseIdentifier: AccomodationsCell.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(accomodationsCollectionView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setDataSource(_ dataSource: AccomodationsCollectionDataSource) {
        accomodationsCollectionView.dataSource = dataSource
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            accomodationsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            accomodationsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            accomodationsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            accomodationsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private extension AccomodationsView {
    func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {

        UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            return AccomodationViewCollectionLayout(section: section).create()
        }
    }
}
