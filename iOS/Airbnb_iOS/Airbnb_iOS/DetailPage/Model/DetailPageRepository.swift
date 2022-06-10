//
//  DetailPageRepository.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/10.
//

import Foundation

protocol DetailPageRepositoryDelegate: AnyObject {
    func didFetchData(_ data: DetailRoomInfo)
}

struct DetailPageRepository {
    weak var delegate: DetailPageRepositoryDelegate?
    
    func fetchData(id: Int) {
        let url = "http://144.24.86.236/rooms/" + "\(id)"
        AlamofireNet().connectNetwork(url: url, method: .get, param: nil, encode: .default) { result in
            switch result {
            case .success(let data):
                guard let decodedData: DetailDTO = JSONConverter.decodeJsonObject(data: data) else {
                    return
                }
                convert(DTO: decodedData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

private extension DetailPageRepository {
    func convert(DTO: DetailDTO) {
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
            let roomDescription = DetailRoomInfo.RoomDescription(roomType: .init(DTO.roomInfo.roomType), numberOfBed: DTO.roomInfo.numberOfBed, numberOfBedRoom: DTO.roomInfo.numberOfBedroom, numberOfBathRoom: DTO.roomInfo.numberOfBathroom, capacity: DTO.roomInfo.capacity)
            let hostInfo = DetailRoomInfo.HostInfo(name: DTO.host.name, profileImageData: hostImage, isSuperHost: DTO.host.superHost)
            let detailRoomInfo = DetailRoomInfo(imageData: imageDataArray, grade: Double(DTO.averageGrade), countReview: DTO.numberOfReviews, name: DTO.name, pricePerDay: DTO.price, finalPrice: DTO.price * 2, description: DTO.description, roomDescription: roomDescription, hostInfo: hostInfo)
            
            delegate?.didFetchData(detailRoomInfo)
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
