//
//  DetailRoomInfo.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/10.
//

import Foundation

struct DetailRoomInfo {
    let imageData: [Data]
    let grade: Double
    let countReview: Int
    let name: String
    let pricePerDay: Int
    let finalPrice: Int
    let description: String
    let roomDescription: RoomDescription
    let hostInfo: HostInfo

    struct RoomDescription {
        let roomType: RoomType
        let numberOfBed: Int
        let numberOfBedRoom: Int
        let numberOfBathRoom: Int
        let capacity: Int
    }

    struct HostInfo {
        let name: String
        let profileImageData: Data
        let isSuperHost: Bool
    }
}

enum RoomType {
    case residence
    case none
    init(_ roomType: String) {
        switch roomType {
        case "RESIDENCE":
            self = .residence
        default:
            self = .none
        }
    }

    var description: String {
        switch self {
        case .residence:
            return "레지던스 전체"
        case .none:
            return "오류"
        }
    }
}
