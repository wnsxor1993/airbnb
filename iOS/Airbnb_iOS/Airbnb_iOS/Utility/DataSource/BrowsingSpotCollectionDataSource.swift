//
//  File.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/27.
//

import UIKit
import MapKit

class BrowsingSpotCollectionDataSource: NSObject, UICollectionViewDataSource {

    private(set) var searchResults = [MKLocalSearchCompletion]()

    func inputMKLocalSearchResults(input: [MKLocalSearchCompletion]) {
        self.searchResults = input
    }

    func removeAllResults() {
        self.searchResults.removeAll()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowsingSpotCell.identifier, for: indexPath) as? BrowsingSpotCell else {
            return UICollectionViewCell()
        }

        let item = searchResults[indexPath.item]
        cell.configure(image: UIImage(systemName: "mappin.square.fill"), title: item.title)

        return cell
    }
}
