//
//  Int+AtlasMapTests.swift
//  Atlas
//
//  Created by Jeremy Fox on 8/3/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import XCTest
@testable import Atlas

class Int_AtlasMapTests: XCTestCase {

    var json: JSON!

    override func setUp() {
        super.setUp()
        let i: Int = 702888806
        let i8: Int8 = 70
        let i16: Int16 = 7028
        let i32: Int32 = 702888806
        let i64: Int64 = 70288880664460
        let dict: [String: Any] = [
            "i": NSNumber(value: i as Int),
            "i8": NSNumber(value: i8 as Int8),
            "i16": NSNumber(value: i16 as Int16),
            "i32": NSNumber(value: i32 as Int32),
            "i64": NSNumber(value: i64 as Int64)
        ]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
        json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as JSON!
    }

    override func tearDown() {
        json = nil
        super.tearDown()
    }

    func testIntMappingMapsIntegerValuesWithinManAndMaxRange() {
        let min = Int.min
        let zero = 0
        let max = Int.max

        XCTAssertEqual(Int(min), Int.min)
        XCTAssertEqual(Int(zero), 0)
        XCTAssertEqual(Int(max), Int.max)
    }

    func testIntMappingPerformance() {
        self.measure {
            for _ in 0..<100_000 {
                let _ = Int(702888806)
            }
        }
    }

    func testIntMappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int(json: (json as AnyObject)["i"]))
    }

    func testInt64MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int64(json: (json as AnyObject)["i64"]))
    }

    func testInt32MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int32(json: (json as AnyObject)["i32"]))
    }

    func testInt16MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int16(json: (json as AnyObject)["i16"]))
    }

    func testInt8MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int8(json: (json as AnyObject)["i8"]))
    }

}
