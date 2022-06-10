//
//  AccomodationDTO.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/09.
//

import Foundation

struct AccomodationDTO: Codable {
    let id: Int
    let averageGrade, numberOfReviews: Int
    let imagePath: String
    let title: String
    let price: Int
}
