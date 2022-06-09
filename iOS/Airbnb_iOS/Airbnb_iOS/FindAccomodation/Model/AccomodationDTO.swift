//
//  AccomodationDTO.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/09.
//

import Foundation

struct AccomodationDTO: Codable {
    let name: String
    let location: Location
    let averageGrade, numberOfReviews: Int
    let roomImages: [RoomImage]
    let roomInfo: RoomInfo
    let description: String
    let price: Int
    let host: Host
}

struct Host: Codable {
    let id: Int
    let name: String
    let profileImagePath: String
    let superHost: Bool
}

struct Location: Codable {
    let latitude, longitude: String
}

struct RoomImage: Codable {
    let id: Int
    let imagePath: String
}

struct RoomInfo: Codable {
    let roomType: String
    let numberOfBedroom, numberOfBed, numberOfBathroom, capacity: Int
    let checkInTime, checkOutTime: String
}
