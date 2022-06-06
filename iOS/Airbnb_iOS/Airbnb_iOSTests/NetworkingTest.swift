//
//  NetworkingTest.swift
//  Airbnb_iOSTests
//
//  Created by juntaek.oh on 2022/06/06.
//

import XCTest
@testable import Airbnb_iOS

final class NetworkingTest: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testExample() throws {
        let getExpectation = XCTestExpectation(description: "APIPrivoderGETExpectation")
        let postExpectation = XCTestExpectation(description: "APIPrivoderPOSTExpectation")
        
        let alamo = AlamofireNet()
        let param = ["product_cd" : "9200000002487"]
        
        var getResult: Data?
        var postResult: Data?
        
        alamo.connectNetwork(url: "https://api.codesquad.kr/onban/main", method: .get, param: nil, completion: { data in
            getResult = data
            getExpectation.fulfill()
        })
        
        alamo.connectNetwork(url: "https://www.starbucks.co.kr/menu/productViewAjax.do", method: .post, param: param, completion: { data in
            postResult = data
            postExpectation.fulfill()
        })
        
        wait(for: [getExpectation, postExpectation], timeout: 10.0)
        
        XCTAssertNotNil(getResult)
        XCTAssertNotNil(postResult)
    }
}
