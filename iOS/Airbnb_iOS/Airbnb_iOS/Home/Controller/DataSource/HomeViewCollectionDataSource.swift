//
//  HomeViewCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/24.
//

import UIKit

final class HomeViewCollectionDataSource: NSObject {

    var data: [MySection] = [
        .first([MySection.FirstItem.init(image: UIImage(named: "heroImage") ?? UIImage())]),
        .second([MySection.SecondItem].init(repeating: MySection.SecondItem.init(image: UIImage(named: "SeoulImage") ?? UIImage(), title: "서울", distance: "차로 30분 거리"), count: 20)),
        .third([MySection.ThirdItem].init(repeating: MySection.ThirdItem.init(image: UIImage(named: "LivingImage") ?? UIImage(), title: "자연생활을 만끽할 수 있는 숙소"), count: 5))
    ]
}

extension HomeViewCollectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch data[section] {
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        case let .third(items):
            return items.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section] {
        case let .first(items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainEventCell.identifier,
                                                                for: indexPath) as? MainEventCell else {
                return UICollectionViewCell()
            }
            cell.configure(image: items[indexPath.item].image)

            return cell
        case let .second(items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AroundSpotCell.identifier,
                                                                for: indexPath) as? AroundSpotCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.item]
            cell.configure(image: item.image, title: item.title, distance: item.distance)

            return cell
        case let .third(items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeSpotCell.identifier,
                                                                for: indexPath) as? ThemeSpotCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.item]
            cell.configure(image: item.image, title: item.title)

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else {
                return UICollectionReusableView()
            }

            switch indexPath.section {
            case 1:
                headerView.setHeaderText(text: "가까운 여행지 둘러보기")
                headerView.setHeaderFontSize(size: 22)
            case 2:
                headerView.setHeaderText(text: """
                                           어디에서나,
                                           여행은 살아보는거야!
                                           """)
                headerView.setHeaderFontSize(size: 22)
            default:
                headerView.setHeaderText(text: nil)
            }

            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

enum MySection {
    case first([FirstItem])
    case second([SecondItem])
    case third([ThirdItem])

    struct FirstItem {
        let image: UIImage
    }

    struct SecondItem {
        let image: UIImage
        let title: String
        let distance: String
    }

    struct ThirdItem {
        let image: UIImage
        let title: String
    }
}
