//
//  DetailPageCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/07.
//

import UIKit

class DetailPageCollectionDataSource: NSObject, UICollectionViewDataSource {

    private var data = DetailPageItem()
    private var isShowMore = false
    
    func toggleIsShowMore() {
        isShowMore.toggle()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DetailPageCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch DetailPageCase.allCases[section] {
        case .zeroCase:
            return data.image.count
        case .firstCase:
            return 1
        case .secondCase:
            return 1
        case .thirdCase:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch DetailPageCase.allCases[indexPath.section] {
        case .zeroCase:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCell.identifier, for: indexPath) as? ThumbnailImageCell else {
                return UICollectionViewCell()
            }
            
            cell.configureImage(imageData: data.image[indexPath.item])
            return cell
            
        case .firstCase:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleTextCell.identifier, for: indexPath) as? TitleTextCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(name: data.titlePage.roomName, rate: data.titlePage.rating, lotate: data.titlePage.place)
            return cell
            
        case .secondCase:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HostTextCell.identifier, for: indexPath) as? HostTextCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(info: data.hostPage.roomInfo, name: data.hostPage.hostName, image: data.hostPage.hostFace, detail: data.hostPage.detailInfo)
            return cell
            
        case .thirdCase:
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

enum DetailPageCase: CaseIterable {
    case zeroCase
    case firstCase
    case secondCase
    case thirdCase
}

struct DetailPageItem {
    let image: [UIImage]
    let titlePage: TitlePage
    let hostPage: HostPage
    let description: DetailPage
    
    init() {
        image = Array(repeating: UIImage(named: "roomImage") ?? UIImage(), count: 8)
        titlePage = TitlePage()
        hostPage = HostPage()
        description = DetailPage()
    }
    
    struct TitlePage {
        let roomName: String
        let rating: String
        let place: String
        
        init() {
            roomName = "Spacious and Comfortable cozy house #4"
            rating = "4.80 (후기 127개)"
            place = "서초구, 서울, 한국"
        }
    }
    
    struct HostPage {
        let roomInfo: String
        let hostName: String
        let hostFace: UIImage
        let detailInfo: String
        
        init() {
            roomInfo = "레지던스 전체"
            hostName = "호스트: Jong님"
            detailInfo = "최대인원 3명∙원룸∙침대 1개∙욕실 1개"
            hostFace = UIImage(named: "host") ?? UIImage()
        }
    }
    
    struct DetailPage {
        let description: String
        
        init() {
            description =
            """
            조선이 임진왜란을 당하여 전쟁 초기 이를 감당하기 어려울 정도로 국력이 쇠약해진 것은 왜란이 일어난 선조대에 이르러서 비롯된 것은 아니었다. 이미 훨씬 이전부터 중쇠(中衰)의 기운이 나타나기 시작하였다.
            정치적으로는 연산군 이후 명종대에 이르는 4대 사화(四大士禍)와 훈구(勳舊)·사림(士林) 세력간에 계속된 정쟁으로 인한 중앙 정계의 혼란, 사림 세력이 득세한 선조 즉위 이후 격화된 당쟁 등으로 정치의 정상적인 운영을 수행하기 어려운 지경이었다.
            """
        }
    }
}
