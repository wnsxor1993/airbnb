//
//  AccomodationViewCollectionLayout.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

struct AccomodationViewCollectionLayout {

    private let section: Int

    init(section: Int) {
        self.section = section
    }

    func create() -> NSCollectionLayoutSection? {
        switch section {
        case 0:
            return AccomodationOptionSection().create()
        case 1:
            return CountAccomodationsSection().create()
        default:
            return AccomodationsSection().create()
        }
    }

    struct AccomodationOptionSection {
        func create() -> NSCollectionLayoutSection? {
            let itemInset: CGFloat = 16

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(16))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(16))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset * 2, leading: itemInset,
                                                            bottom: itemInset/2, trailing: itemInset)

            return section
        }
    }

    struct CountAccomodationsSection {
        func create() -> NSCollectionLayoutSection? {
            let itemInset: CGFloat = 16

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(28))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .estimated(28))
             let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemInset,
                                                            bottom: itemInset*4/3, trailing: itemInset)

            return section
        }
    }

    struct AccomodationsSection {
        func create() -> NSCollectionLayoutSection? {
            let itemInset: CGFloat = 16

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 0,
                bottom: itemInset*4/3, trailing: 0)

            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                           heightDimension: .estimated(420)),
                                                         subitem: item, count: 1)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemInset,
                                                            bottom: itemInset*4/3, trailing: itemInset)
            
            return section
        }
    }
}
