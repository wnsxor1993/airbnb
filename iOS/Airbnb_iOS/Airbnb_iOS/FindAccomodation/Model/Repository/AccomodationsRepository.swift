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
        AlamofireNet().connectNetwork(url: baseURL, method: .get, param: nil, encode: .default) { result in
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
        for DTO in DTOs {
            let dispatchGroup = DispatchGroup()
            let serialQueue = DispatchQueue.init(label: "SerialQueue")
            var imageDataArray = [Data]()
            var hostImage = Data()

            dispatchGroup.enter()
            DTO.roomImages.forEach {
                fetchImage(url: $0.imagePath) { imageData in
                    serialQueue.async {
                        imageDataArray.append(imageData)
                    }
                }
            }

            fetchImage(url: DTO.host.profileImagePath) { imageData in
                serialQueue.async {
                    hostImage = imageData
                }
                dispatchGroup.leave()
            }

            let endQueue = DispatchQueue.init(label: "EndQueue", attributes: .concurrent)

            dispatchGroup.notify(queue: endQueue) {
                let roomDescription = AccomodationsViewComponentsData.AccomodationInfo.RoomDescription(roomType: .init(DTO.roomInfo.roomType), numberOfBed: DTO.roomInfo.numberOfBed, numberOfBedRoom: DTO.roomInfo.numberOfBedroom, numberOfBathRoom: DTO.roomInfo.numberOfBathroom, capacity: DTO.roomInfo.capacity)
                let hostInfo = AccomodationsViewComponentsData.AccomodationInfo.HostInfo(name: DTO.host.name, profileImageData: hostImage, isSuperHost: DTO.host.superHost)
                let accomodationInfo = AccomodationsViewComponentsData.AccomodationInfo(imageData: imageDataArray, grade: Double(DTO.averageGrade), countReview: DTO.numberOfReviews, name: DTO.name, pricePerDay: DTO.price, finalPrice: DTO.price * 2, description: DTO.description, roomDescription: roomDescription, hostInfo: hostInfo)
                print(accomodationInfo)

                delegate?.didFetchedData(accomodationInfo)
            }
        }
    }

    func fetchImage(url: String, handler: @escaping (Data) -> Void) {
        AlamofireNet().connectNetwork(url: url, method: .get, param: nil, encode: .default) { result in
            switch result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
