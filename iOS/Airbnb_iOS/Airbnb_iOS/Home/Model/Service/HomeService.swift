//
//  HomeService.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation

protocol HomeServiceDelegate: AnyObject {
    func didFetchHeroImageData(_ heroImageData: HomeViewComponentsData.HeroImageData)
    func didFetchAroundSpotData(_ aroundSpotData: HomeViewComponentsData.AroundSpotData)
    func didFetchThemeSpotData(_ themeSpotData: HomeViewComponentsData.ThemeSpotData)
}

struct HomeService {
    private weak var delegate: HomeServiceDelegate?

    func fetchData(currentLocation: (latitude: Double, longitude: Double)) {
        // 대략적으로 네트워크를 이용했을 때의 코드 구현
//        let baseURL = "https://test.com"
//        let param = [
//            "latitude": currentLocation.latitude,
//            "longitude": currentLocation.longitude
//        ]
//
//        AlamofireNet().connectNetwork(url: baseURL, method: .post, param: param) { result in
//            switch result {
//            case .success(let data):
//                guard let decodedData: HomeDto = JSONConverter.decodeJsonObject(data: data) else {
//                    return
//                }
//                let convertedData = convert(DTO: decodedData)
//            case .failure(let error):
//                print(error)
//            }
//
//        }

        // mock.json 파일을 사용하기 위한 코드 (아직 서버가 올라와있지 않음)
        guard let mockJsonPath = Bundle.main.url(forResource: "mock", withExtension: "json"),
              let jsonData = try? Data(contentsOf: mockJsonPath),
              let decodedData: HomeDto = JSONConverter.decodeJsonObject(data: jsonData) else {
            return
        }

        convert(DTO: decodedData)
    }

    mutating func setDelegate(_ delegate: HomeServiceDelegate) {
        self.delegate = delegate
    }
}

private extension HomeService {
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
                distanceDescription: DTO.distance.toKM())
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
