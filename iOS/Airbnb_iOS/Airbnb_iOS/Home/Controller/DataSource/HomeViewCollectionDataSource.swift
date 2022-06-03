//
//  HomeViewCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/24.
//

import UIKit

final class HomeViewCollectionDataSource: NSObject {

    var data = [HomeViewComponentsData]()
}

extension HomeViewCollectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch data[section] {
        case .firstSection:
            return 1
        case let .secondSection(items):
            return items.count
        case let .thirdSection(items):
            return items.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section] {
        case let .firstSection(heroImageData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainEventCell.identifier, for: indexPath) as? MainEventCell else {
                return UICollectionViewCell()
            }

            cell.configure(image: UIImage(data: heroImageData.imageData))
            return cell
        case let .secondSection(aroundSpotData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AroundSpotCell.identifier, for: indexPath) as? AroundSpotCell else {
                return UICollectionViewCell()
            }

            let item = aroundSpotData[indexPath.item]
            cell.configure(image: UIImage(data: item.imageData), title: item.title, distance: item.distanceDescription)
            return cell
        case let .thirdSection(themeSpotData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeSpotCell.identifier, for: indexPath) as? ThemeSpotCell else {
                return UICollectionViewCell()
            }

            let item = themeSpotData[indexPath.item]
            cell.configure(image: UIImage(data: item.imageData), title: item.title)
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
                headerView.setHeaderText(text: "어디에서나, 여행은\n살아보는거야!")
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
