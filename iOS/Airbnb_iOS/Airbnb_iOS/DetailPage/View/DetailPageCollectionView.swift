//
//  DetailPageCollectionView.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import UIKit

class DetailPageCollectionView: UIView {
    
    private(set) lazy var collectionView: UICollectionView = {
        // 여기 수정 필요
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true

        collectionView.register(ThumbnailImageCell.self, forCellWithReuseIdentifier: ThumbnailImageCell.identifier)
        collectionView.register(TitleTextCell.self, forCellWithReuseIdentifier: TitleTextCell.identifier)
        collectionView.register(HostTextCell.self, forCellWithReuseIdentifier: HostTextCell.identifier)
        collectionView.register(DetailTextCell.self, forCellWithReuseIdentifier: DetailTextCell.identifier)
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
        // 여기 수정 필요
        collectionView.dataSource = dataSource
    }
}

private extension DetailPageCollectionView {

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
        UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            // 여기 수정 필요
            return HomeViewCollectionLayout(section: section).create()
        }
    }
}
