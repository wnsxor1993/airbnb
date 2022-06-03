//
//  File.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/27.
//

import UIKit
import MapKit

class BrowsingSpotCollectionDataSource: NSObject, UICollectionViewDataSource {

    private(set) var searchManager: MKDataManager?

    func connectDataManager(manager: MKDataManager) {
        self.searchManager = manager
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchManager?.searchResults.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowsingSpotCell.identifier, for: indexPath) as? BrowsingSpotCell, let results = searchManager?.searchResults else {
            return UICollectionViewCell()
        }

        let item = results[indexPath.item]
        cell.configure(image: UIImage(systemName: "mappin.square.fill"), title: item.title, subText: item.subtitle)

        return cell
    }
}
