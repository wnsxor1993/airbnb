//
//  JSONConverterTests.swift
//  Airbnb_iOSTests
//
//  Created by 김한솔 on 2022/06/06.
//

import XCTest
@testable import Airbnb_iOS

final class JSONConverterTests: XCTestCase {
    func test_decodeJsonObject호출시_mockjson파일을_디코딩하는지() {
        let path = Bundle.main.url(forResource: "mock", withExtension: "json")
        XCTAssertNotNil(path)
        
        let jsonData = try? Data(contentsOf: path!)
        XCTAssertNotNil(jsonData)
        
        let result: TestDTO? = JSONConverter.decodeJsonObject(data: jsonData!)
        XCTAssertNotNil(result)
    }
    
    func test_encodeJsonObject호출시_JSON파일로_인코딩되는지() {
        let targetParam = TestDTO(
            heroImage: .init(imageURL: "url", title: "title", heroImageDescription: "description", buttonTitle: "buttontitle"),
            aroundSpot: .init(imageURL: "url", title: "title", location: [100.1, 100.2], 거리: 300),
            themeSpot: .init(imageURL: "url", title: "title"))
        
        let result = JSONConverter.encodeJsonObject(param: targetParam)
        XCTAssertNotNil(result)
    }
}

private extension JSONConverterTests {
    struct TestDTO: Codable {
        let heroImage: HeroImage
        let aroundSpot: AroundSpot
        let themeSpot: ThemeSpot

        enum CodingKeys: String, CodingKey {
            case heroImage = "hero_image"
            case aroundSpot, themeSpot
        }
    }
    struct AroundSpot: Codable {
        let imageURL: String
        let title: String
        let location: [Double]
        let 거리: Int
    }

    struct HeroImage: Codable {
        let imageURL: String
        let title, heroImageDescription, buttonTitle: String

        enum CodingKeys: String, CodingKey {
            case imageURL, title
            case heroImageDescription = "description"
            case buttonTitle
        }
    }

    struct ThemeSpot: Codable {
        let imageURL: String
        let title: String
    }

}
