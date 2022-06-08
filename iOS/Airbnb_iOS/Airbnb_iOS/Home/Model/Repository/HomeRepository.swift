//
//  HomeRepository.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation

protocol HomeRepositoryDelegate: AnyObject {
    func didFetchHeroImageData(_ heroImageData: HomeViewComponentsData.HeroImageData)
    func didFetchAroundSpotData(_ aroundSpotData: HomeViewComponentsData.AroundSpotData)
    func didFetchThemeSpotData(_ themeSpotData: HomeViewComponentsData.ThemeSpotData)
}

struct HomeRepository {
    private weak var delegate: HomeRepositoryDelegate?

    func fetchData(currentLocation: (latitude: Double, longitude: Double)) {
        let baseURL = "http://144.24.86.236/home"
        let param = [
            "x": currentLocation.latitude,
            "y": currentLocation.longitude
        ]

        AlamofireNet().connectNetwork(url: baseURL, method: .get, param: param) { result in
            switch result {
            case .success(let data):
                guard let decodedData: HomeDto = JSONConverter.decodeJsonObject(data: data) else {
                    return
                }
                convert(DTO: decodedData)
            case .failure(let error):
                print(error)
            }

        }
    }

    mutating func setDelegate(_ delegate: HomeRepositoryDelegate) {
        self.delegate = delegate
    }
}

private extension HomeRepository {
    func convert(DTO: HomeDto) {
        convertToHeroImageData(DTO: DTO.mainEventDto)
        DTO.aroundSpotDto.forEach { eachAroundSpotDto in
            convertToAroundSpotData(DTO: eachAroundSpotDto)
        }
        DTO.themeSpotDto.forEach { eachThemeSpotDto in
            convertToThemeSpotData(DTO: eachThemeSpotDto)
        }
    }

    func convertToHeroImageData(DTO: MainEventDto) {
        fetchImage(url: DTO.imagePath) { imageData in
            let heroImageData = HomeViewComponentsData.HeroImageData.init(
                imageData: imageData,
                title: DTO.title,
                description: DTO.label,
                buttonTitle: DTO.buttonText)
            delegate?.didFetchHeroImageData(heroImageData)
        }
    }

    func convertToAroundSpotData(DTO: AroundSpotDto) {
        fetchImage(url: DTO.imagePath) { imageData in
            let aroundSpotData = HomeViewComponentsData.AroundSpotData.init(
                imageData: imageData,
                title: DTO.title,
                distance: DTO.distance)
            delegate?.didFetchAroundSpotData(aroundSpotData)
        }
    }

    func convertToThemeSpotData(DTO: ThemeSpotDto) {
        fetchImage(url: DTO.imagePath) { imageData in
            let themeSpotData = HomeViewComponentsData.ThemeSpotData.init(
                imageData: imageData,
                title: DTO.title)
            delegate?.didFetchThemeSpotData(themeSpotData)
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
