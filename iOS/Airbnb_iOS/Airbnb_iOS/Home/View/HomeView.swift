//
//  HomeView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit

final class HomeView: UIView {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true

        collectionView.register(MainEventCell.self, forCellWithReuseIdentifier: MainEventCell.identifier)
        collectionView.register(AroundSpotCell.self, forCellWithReuseIdentifier: AroundSpotCell.identifier)
        collectionView.register(ThemeSpotCell.self, forCellWithReuseIdentifier: ThemeSpotCell.identifier)

        collectionView.register(CollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CollectionHeaderView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
}

private extension HomeView {

    func setUpLayout() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            return HomeViewCollectionLayout(section: section).create()
        }
    }
}
