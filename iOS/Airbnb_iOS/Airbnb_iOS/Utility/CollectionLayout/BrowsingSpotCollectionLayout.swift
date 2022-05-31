//
//  BrowseViewCollectionLayout.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/30.
//

import UIKit

struct BrowsingSpotCollectionLayout {
    
    private let isBrowsing: Bool

    init(isBrowsing: Bool) {
        self.isBrowsing = isBrowsing
    }
    
    func create() -> NSCollectionLayoutSection? {
        switch isBrowsing {
        case true:
            let itemFractionalWidthFraction = 0.8

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                heightDimension: .fractionalHeight(1/8))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 10, bottom: 16, trailing: 0)

            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7)), subitem: item, count: 8)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)

            return section
            
        case false:
            let itemFractionalWidthFraction = 0.8

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                heightDimension: .fractionalHeight(1/8))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 10, bottom: 16, trailing: 0)

            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7)), subitem: item, count: 8)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(22))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]

            return section
        }
    }
}
