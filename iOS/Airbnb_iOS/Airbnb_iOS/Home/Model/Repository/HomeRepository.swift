//
//  HomeRepository.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation
import Alamofire

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
            "x": currentLocation.longitude,
            "y": currentLocation.latitude
        ]

        AlamofireNet().connectNetwork(url: baseURL, method: .get, param: param, encode: .queryString) { result in
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
        
        self.postNotification()
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
        
        self.postNotification()
    }

    func convertToAroundSpotData(DTO: AroundSpotDto) {
        fetchImage(url: DTO.imagePath) { imageData in
            let aroundSpotData = HomeViewComponentsData.AroundSpotData.init(
                imageData: imageData,
                title: DTO.title,
                time: Int(DTO.time) ?? 0)
            delegate?.didFetchAroundSpotData(aroundSpotData)
        }
        
        self.postNotification()
    }

    func convertToThemeSpotData(DTO: ThemeSpotDto) {
        fetchImage(url: DTO.imagePath) { imageData in
            let themeSpotData = HomeViewComponentsData.ThemeSpotData.init(
                imageData: imageData,
                title: DTO.title)
            delegate?.didFetchThemeSpotData(themeSpotData)
        }
        
        self.postNotification()
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
    
    func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("repository"), object: self)
    }
}
