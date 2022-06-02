//
//  BrowseCollectionView.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/25.
//

import UIKit

class BorwsingSpotCollectionView: UIView {
    
    private(set) var isBrowsing: Bool = false

    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true

        collectionView.register(AroundSpotCell.self, forCellWithReuseIdentifier: AroundSpotCell.identifier)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.identifier)
        collectionView.register(BrowsingSpotCell.self, forCellWithReuseIdentifier: BrowsingSpotCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func startToSearch() {
        self.isBrowsing = true
        self.collectionView.collectionViewLayout = self.getCollectionViewLayout()
    }
    
    func stopToSearch() {
        self.isBrowsing = false
        self.collectionView.collectionViewLayout = self.getCollectionViewLayout()
    }
}

private extension BorwsingSpotCollectionView {

    func setConstraint() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            return BrowsingSpotCollectionLayout(isBrowsing: self.isBrowsing).create()
        }
    }
}
