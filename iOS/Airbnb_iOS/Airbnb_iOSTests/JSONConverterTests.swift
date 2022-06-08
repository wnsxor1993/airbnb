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
        
        let result: HomeDto? = JSONConverter.decodeJsonObject(data: jsonData!)
        XCTAssertNotNil(result)
    }
    
    func test_encodeJsonObject호출시_JSON파일로_인코딩되는지() {
        let targetParam = HomeDto(
            mainEventDto: .init(title: "title",
                                label: "label",
                                imagePath: "imagePath",
                                buttonText: "buttonText"),
            aroundSpotDto: [.init(title: "title",
                                  distance: 0,
                                  imagePath: "imagePath")],
            themeSpotDto: [.init(imagePath: "imagePath",
                                 title: "title")])
        
        let result = JSONConverter.encodeJsonObject(param: targetParam)
        XCTAssertNotNil(result)
    }
}
