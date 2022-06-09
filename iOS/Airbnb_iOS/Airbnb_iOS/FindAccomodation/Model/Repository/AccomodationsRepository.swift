//
//  AccomodationsRepository.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/09.
//

import Foundation

protocol AccomodationsRepositoryDelegate: AnyObject {
    func didFetchedData(_ data: AccomodationsViewComponentsData.AccomodationInfo)
}

struct AccomodationsRepository {
    private weak var delegate: AccomodationsRepositoryDelegate?

    func fetchData() {
        let baseURL = "http://144.24.86.236/room/1"
        AlamofireNet().connectNetwork(url: baseURL, method: .get, param: nil) { result in
            switch result {
            case .success(let data):
//                guard let decodedData: [AccomodationDTO] = JSONConverter.decodeJsonObject(data: data) else {
//                    return
//                }
//
//                convert(DTOs: decodedData)
                // 아직 API가 없어, 임의로..
                guard let decodedData: AccomodationDTO = JSONConverter.decodeJsonObject(data: data) else { return }
                convert(DTOs: [decodedData])
            case .failure(let error):
                print(error)
            }
        }
    }

    mutating func setDelegate(_ delegate: AccomodationsRepositoryDelegate) {
        self.delegate = delegate
    }
}

private extension AccomodationsRepository {
    func convert(DTOs: [AccomodationDTO]) {
//        for DTO in DTOs {
//            let roomDescription = AccomodationsViewComponentsData.AccomodationInfo.RoomDescription(
//                roomType: .init(DTO.roomInfo.roomType),
//                numberOfBed: DTO.roomInfo.numberOfBed,
//                numberOfBedRoom: DTO.roomInfo.numberOfBedroom,
//                numberOfBathRoom: DTO.roomInfo.numberOfBathroom,
//                capacity: DTO.roomInfo.capacity)
//
//            let dispatchGroup = DispatchGroup()
//            dispatchGroup.enter()
//
//            var hostInfo: AccomodationsViewComponentsData.AccomodationInfo.HostInfo
//            fetchImage(url: DTO.host.profileImagePath) { data in
//                hostInfo = AccomodationsViewComponentsData.AccomodationInfo.HostInfo(name: DTO.host.name,
//                                                                                         profileImageData: data,
//                                                                                         isSuperHost: DTO.host.superHost)
//                dispatchGroup.leave()
//            }
//
//            DTO.roomImages.forEach { image in
//                fetchImage(url: image.imagePath) { data in
//                    let accomodationsComponentsData = AccomodationsViewComponentsData.AccomodationInfo(imageData: <#T##[Data]#>, grade: <#T##Double#>, countReview: <#T##Int#>, name: <#T##String#>, pricePerDay: <#T##Int#>, finalPrice: <#T##Int#>, description: <#T##String#>, roomDescription: roomDescription, hostInfo: hostInfo)
//                    dispatchGroup.leave()
//                }
//            }
//
//            let queueForGroup = DispatchQueue(label: "endQueue", attributes: .concurrent)
//            dispatchGroup.notify(queue: queueForGroup) {
//
//            }
//        }
        // 방법 생각이 조금 더 필요할 듯... 이미지 fetch가 너무 많아 어떻게 해야할지 모르겠음

        for DTO in DTOs {
            fetchImage(url: DTO.roomImages[0].imagePath) { imageData in
                let accomodationInfo = AccomodationsViewComponentsData.AccomodationInfo(
                    imageData: imageData,
                    grade: Double(DTO.averageGrade),
                    countReview: DTO.numberOfReviews,
                    name: DTO.name,
                    pricePerDay: DTO.price,
                    finalPrice: DTO.price * 4)

                delegate?.didFetchedData(accomodationInfo)
            }
        }
    }

    func fetchImage(url: String, handler: @escaping (Data) -> Void) {
        AlamofireNet().connectNetwork(url: url, method: .get, param: nil) { result in
            switch result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
