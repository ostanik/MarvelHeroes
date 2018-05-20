//
//  BaseProviderTest.swift
//  MarvelHerosTests
//
//  Created by Alan Ostanik on 2018-05-19.
//  Copyright © 2018 Ostanik. All rights reserved.
//

import XCTest
@testable import MarvelHeros

class BaseProviderTest: XCTestCase {
    let sut = BaseDataProvider()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApiHashGeneration() {
        let expectedResult = "1d8a3cdc0db5fa0f3c6c0cbcb80753bd"
        let result = sut.requestHash(timestamp: "timestamp", apiPrivateKey: "privatekey", apiPublicKey: "publickey")
        XCTAssertEqual(result, expectedResult)
    }

    func testApiAuthenticationParametersString() {
        let expectedResult = "ts=timestamp&apikey=publickey&hash=1d8a3cdc0db5fa0f3c6c0cbcb80753bd"
        let result = sut.requestAutenticationParameters(timestamp: "timestamp", apiPublicKey: "publickey", hash: "1d8a3cdc0db5fa0f3c6c0cbcb80753bd")
        XCTAssertEqual(result, expectedResult)
    }
    
}
