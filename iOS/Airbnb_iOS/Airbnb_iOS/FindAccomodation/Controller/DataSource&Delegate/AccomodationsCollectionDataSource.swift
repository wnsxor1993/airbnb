//
//  AccomodationsCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class AccomodationsCollectionDataSource: NSObject {
    var data: [AccomodationsViewComponentsData] = [
        .accomodationOptionSection(nil),
        .countAccomodationsSection(count: 0),
        .accomodationsSection([])
    ]
}

extension AccomodationsCollectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch data[section] {
        case let .accomodationsSection(items):
            return items?.count ?? 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section] {
        case let .accomodationOptionSection(optionInfo):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccomodationOptionCell.identifier, for: indexPath) as? AccomodationOptionCell else {
                return UICollectionViewCell()
            }

            cell.configure(location: optionInfo?.locationName, dateRange: DateConverter.convertToDateRangeString(dateRange: optionInfo?.dateRange))

            return cell
        case let .countAccomodationsSection(count):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountAccomodationsCell.identifier, for: indexPath) as? CountAccomodationsCell else {
                return UICollectionViewCell()
            }

            cell.configure(countAccomodations: count)

            return cell
        case let .accomodationsSection(items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccomodationsCell.identifier, for: indexPath) as? AccomodationsCell,
                  let item = items?[indexPath.item] else {
                return UICollectionViewCell()
            }

            var imageData: Data
            
            if item.imageData.count > 0 {
                imageData = item.imageData
            } else {
                imageData = Data()
            }

            var distanceOfDate = 0

            if case let AccomodationsViewComponentsData.accomodationOptionSection(option) = data[0] {
                distanceOfDate = Calendar.current.dateComponents([.day], from: option?.dateRange?.lowerBound ?? Date(), to: option?.dateRange?.upperBound ?? Date()).day ?? 0
            }
            
            cell.configure(imageData: imageData,
                           grade: Double(item.averageGrade),
                           countReview: item.numberOfReviews,
                           name: item.title,
                           pricePerDay: item.price,
                           finalPrice: item.price * distanceOfDate)

            return cell
        }
    }
    
}
