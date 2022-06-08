//
//  NetworkingTest.swift
//  Airbnb_iOSTests
//
//  Created by juntaek.oh on 2022/06/06.
//

import XCTest
import Alamofire
@testable import Airbnb_iOS

final class NetworkingTest: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testExample() throws {
        let getExpectation = XCTestExpectation(description: "APIPrivoderGETExpectation")
        let postExpectation = XCTestExpectation(description: "APIPrivoderPOSTExpectation")
        
        let alamo = AlamofireNet()
        let param = ["product_cd" : "9200000002487"]
        
        var getResult: Result<Data, AFError>?
        var postResult: Result<Data, AFError>?
        
        alamo.connectNetwork(url: "https://api.codesquad.kr/onban/main", method: .get, param: nil, completion: { result in
            getResult = result
            getExpectation.fulfill()
        })
        
        alamo.connectNetwork(url: "https://www.starbucks.co.kr/menu/productViewAjax.do", method: .post, param: param, completion: { result in
            postResult = result
            postExpectation.fulfill()
        })
        
        wait(for: [getExpectation, postExpectation], timeout: 10.0)
        
        XCTAssertNotNil(getResult)
        XCTAssertNotNil(postResult)
    }
}
