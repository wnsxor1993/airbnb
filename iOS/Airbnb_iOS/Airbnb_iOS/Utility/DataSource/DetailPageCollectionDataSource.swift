//
//  DetailPageCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/07.
//

import UIKit

class DetailPageCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    enum DetailPageCase: CaseIterable {
        case mainImages
        case roomTitle
        case hostTitle
        case description
    }

    var data = DetailRoomInfo(
        imageData: [],
        grade: 0,
        countReview: 0,
        name: "",
        pricePerDay: 0,
        finalPrice: 0,
        description: "",
        roomDescription: .init(roomType: .none,
                              numberOfBed: 0,
                              numberOfBedRoom: 0,
                              numberOfBathRoom: 0,
                              capacity: 0),
        hostInfo: .init(name: "",
                        profileImageData: Data(),
                        isSuperHost: false))

    private var isShowMore = false
    
    init(data: AccomodationsViewComponentsData.AccomodationInfo) {
        self.data = data
    }
    
    func toggleIsShowMore() {
        isShowMore.toggle()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DetailPageCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch DetailPageCase.allCases[section] {
        case .mainImages:
            return data.imageData.count
        case .roomTitle:
            return 1
        case .hostTitle:
            return 1
        case .description:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch DetailPageCase.allCases[indexPath.section] {
        case .mainImages:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCell.identifier, for: indexPath) as? ThumbnailImageCell else {
                return UICollectionViewCell()
            }
            
            let image = UIImage(data: data.imageData[indexPath.item])
            cell.configureImage(imageData: image)
            return cell
            
        case .roomTitle:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleTextCell.identifier, for: indexPath) as? TitleTextCell else {
                return UICollectionViewCell()
            }
            
            let rate = "\(data.grade) (후기 \(data.countReview)개)"
            
            cell.configure(name: data.name, rate: rate, lotate: "test")
            return cell
            
        case .hostTitle:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HostTextCell.identifier, for: indexPath) as? HostTextCell else {
                return UICollectionViewCell()
            }
            
            let hostName = "호스트: \(data.hostInfo.name)님"
            let hostImage = UIImage(data: data.hostInfo.profileImageData)
            let detail = "최대인원 \(data.roomDescription.capacity)명 * 침실 \(data.roomDescription.numberOfBedRoom)개 * 침대 \(data.roomDescription.numberOfBed)개 * 욕실 \(data.roomDescription.numberOfBathRoom)개"
            
            cell.configure(info: data.roomDescription.roomType.description, name: hostName, image: hostImage, detail: detail)
            return cell
            
        case .description:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTextCell.identifier, for: indexPath) as? DetailTextCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(detail: data.description.description)
            
            if isShowMore {
                cell.changeNoLimitNumberOfLines()
            } else {
                cell.changeLimitNumberOfLines()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionFooterView.identifier, for: indexPath) as? CollectionFooterView else {
            return UICollectionReusableView()
        }

        return footerView
    }
}
