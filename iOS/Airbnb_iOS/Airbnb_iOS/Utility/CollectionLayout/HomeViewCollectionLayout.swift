//
//  CollectionViewLayoutSetter.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/26.
//

import UIKit

struct HomeViewCollectionLayout {

    private let section: Int

    init(section: Int) {
        self.section = section
    }

    func create() -> NSCollectionLayoutSection? {
        switch section {
        case 0:
            return HomeViewZeroCaseLayoutSection().create()
        case 1:
            return HomeViewFirstCaseLayoutSection().create()
        default:
            return HomeViewDefaultLayoutSection().create()
        }
    }

    struct HomeViewZeroCaseLayoutSection {
        func create() -> NSCollectionLayoutSection? {
            let itemFractionalWidthFraction = 1.0
            let groupFractionalHeightFraction = 1.0 / 2.0
            let itemInset: CGFloat = 0

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset,
                                                         bottom: 40, trailing: itemInset)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(groupFractionalHeightFraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset,
                                                            bottom: itemInset, trailing: itemInset)

            return section
        }
    }

    struct HomeViewFirstCaseLayoutSection {
        func create() -> NSCollectionLayoutSection? {
            let itemFractionalWidthFraction = 0.8
            let itemInset: CGFloat = 2.5

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 16,
                                                         bottom: 24, trailing: itemInset)

            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.75),
                                                                           heightDimension: .estimated(200)),
                                                         subitem: item, count: 2)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset,
                                                            bottom: itemInset, trailing: itemInset)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuous

            return section
        }
    }

    struct HomeViewDefaultLayoutSection {
        func create() -> NSCollectionLayoutSection? {
            let itemFractionalWidthFraction = 0.8
            let itemInset: CGFloat = 2.5

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 28, leading: 16, bottom: 24, trailing: 0)

            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(335),
                                                                           heightDimension: .estimated(420)),
                                                         subitem: item, count: 1)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset,
                                                            bottom: itemInset, trailing: itemInset)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuous

            return section
        }
    }
}
