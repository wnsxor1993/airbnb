//
//  HomeDto.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/06.
//

import Foundation

struct HomeDto: Codable {
    let mainEventDto: MainEventDto
    let aroundSpotDto: [AroundSpotDto]
    let themeSpotDto: [ThemeSpotDto]
}

struct AroundSpotDto: Codable {
    let title: String
    let time: String
    let imagePath: String
}

struct MainEventDto: Codable {
    let title: String
    let label: String
    let imagePath: String
    let buttonText: String
}

struct ThemeSpotDto: Codable {
    let imagePath: String
    let title: String
}
