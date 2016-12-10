//
//  UInt+AtlasMapTests.swift
//  Atlas
//
//  Created by Jeremy Fox on 8/5/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import XCTest
#if os(tvOS)
    @testable import AtlasTV
#else
    @testable import Atlas
#endif

class UInt_AtlasMapTests: XCTestCase {

    var json: JSON!

    override func setUp() {
        super.setUp()
        let i: UInt = 702888806
        let i8: UInt8 = 70
        let i16: UInt16 = 7028
        let i32: UInt32 = 702888806
        let i64: UInt64 = 70288880664460
        let dict: [String: Any] = [
            "ui": NSNumber(value: i as UInt),
            "ui8": NSNumber(value: i8 as UInt8),
            "ui16": NSNumber(value: i16 as UInt16),
            "ui32": NSNumber(value: i32 as UInt32),
            "ui64": NSNumber(value: i64 as UInt64)
        ]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
        json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as JSON!
    }

    override func tearDown() {
        json = nil
        super.tearDown()
    }

    func testUIntMappingMapsIntegerValuesWithinManAndMaxRange() {
        let min = UInt.min
        let max = UInt.max

        XCTAssertEqual(UInt(min), UInt.min)
        XCTAssertEqual(UInt(max), UInt.max)
    }

    func testIntMappingPerformance() {
        self.measure {
            for _ in 0..<100_000 {
                let _ = UInt(702888806)
            }
        }
    }

    func testUIntMappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt(json: (json as AnyObject)["ui"]))
    }

    func testUInt64MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt64(json: (json as AnyObject)["ui64"]))
    }

    func testUInt32MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt32(json: (json as AnyObject)["ui32"]))
    }

    func testUInt16MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt16(json: (json as AnyObject)["ui16"]))
    }

    func testUInt8MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt8(json: (json as AnyObject)["ui8"]))
    }

}
