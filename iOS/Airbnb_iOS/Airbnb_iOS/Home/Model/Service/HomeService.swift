//
//  HomeService.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation
import UIKit // UIKit 임의로 추가

struct HomeService {
    func fetchData(completion: @escaping (Result<[HomeViewComponentsData], Error>) -> Void) {
        // 네트워크 통신 관련 로직 필요
        let componentsData: [HomeViewComponentsData] = [
            .firstSection(.init(
                imageData: (UIImage(named: "heroImage") ?? UIImage()).pngData() ?? Data(),
                title: "슬기로운\n자연생활",
                description: "에어비앤비가 엄선한\n위시리스트를 만나보세요.",
                buttonTitle: "여행 아이디어 얻기")),
            .secondSection(
                [HomeViewComponentsData.AroundSpotData]
                    .init(repeating: .init(
                        imageData: (UIImage(named: "SeoulImage")?.pngData() ?? Data()),
                        title: "서울",
                        distanceDescription: "차로 30분 거리"),
                          count: 20)),
            .thirdSection([HomeViewComponentsData.ThemeSpotData]
                .init(repeating: .init(
                    imageData: (UIImage(named: "LivingImage") ?? UIImage())?.pngData() ?? Data(),
                    title: "자연생활을 만끽할 수 있는 숙소"),
                      count: 5))
        ]

        completion(.success(componentsData))
    }
}
