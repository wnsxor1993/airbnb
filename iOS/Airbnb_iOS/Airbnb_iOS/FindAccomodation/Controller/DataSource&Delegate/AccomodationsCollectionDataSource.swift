//
//  AccomodationsCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class AccomodationsCollectionDataSource: NSObject {
    // 임시로 데이터를 가지고 있도록 구현
    var data: [AccomodationsViewComponentsData] = [
        .accomodationOptionSection(nil),
        .countAccomodationsSection(count: 3),
        .accomodationsSection([
            .init(imageData: UIImage(named: "LivingImage")?.pngData() ?? Data(), grade: 5.0, countReview: 178, name: "Spacious and Comfortable cozy House", pricePerDay: 82953, finalPrice: 1493157),
            .init(imageData: UIImage(named: "LivingImage")?.pngData() ?? Data(), grade: 5.0, countReview: 178, name: "Spacious and Comfortable cozy House", pricePerDay: 82953, finalPrice: 1493157),
            .init(imageData: UIImage(named: "LivingImage")?.pngData() ?? Data(), grade: 5.0, countReview: 178, name: "Spacious and Comfortable cozy House", pricePerDay: 82953, finalPrice: 1493157)
        ])
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

            cell.configure(imageData: item.imageData,
                           grade: item.grade,
                           countReview: item.countReview,
                           name: item.name,
                           pricePerDay: item.pricePerDay,
                           finalPrice: item.finalPrice)

            return cell
        }
    }
    
}
