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
        let baseURL = "http://144.24.86.236/rooms"
        AlamofireNet().connectNetwork(url: baseURL, method: .get, param: nil, encode: .default) { result in
            switch result {
            case .success(let data):
                guard let decodedData: [AccomodationDTO] = JSONConverter.decodeJsonObject(data: data) else {
                    return
                }
                convert(DTOs: decodedData)

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
            fetchImage(url: DTO.imagePath) { imageData in
                let roomData = AccomodationsViewComponentsData.AccomodationInfo(
                    id: DTO.id,
                    title: DTO.title,
                    averageGrade: DTO.averageGrade,
                    numberOfReviews: DTO.numberOfReviews,
                    imageData: imageData,
                    price: DTO.price)
                delegate?.didFetchedData(roomData)
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
