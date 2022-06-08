//
//  File.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/27.
//

import UIKit

class FamousSpotCollectionDataSource: NSObject, UICollectionViewDataSource {

    var data = [HomeViewComponentsData.AroundSpotData]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AroundSpotCell.identifier, for: indexPath) as? AroundSpotCell else {
            return UICollectionViewCell()
        }

        let item = data[indexPath.item]
        cell.configure(imageData: item.imageData, title: item.title, distance: item.distance)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else {
            return UICollectionReusableView()
        }

        headerView.setHeaderText(text: "근처의 인기 여행지")
        headerView.setHeaderFontSize(size: 17)

        return headerView
    }
}
