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
        let dict: [String: AnyObject] = [
            "ui": NSNumber(unsignedLong: i),
            "ui8": NSNumber(unsignedChar: i8),
            "ui16": NSNumber(unsignedShort: i16),
            "ui32": NSNumber(unsignedInt: i32),
            "ui64": NSNumber(unsignedLongLong: i64)
        ]
        let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
        json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
    }
    
    override func tearDown() {
        json = nil
        super.tearDown()
    }
    
    func testUIntMappingMapsIntegerValuesWithinManAndMaxRange() {
        let min = UInt.min
        let max = UInt.max
        
        XCTAssertEqual(try! UInt(json: min), UInt.min)
        XCTAssertEqual(try! UInt(json: max), UInt.max)
    }
    
    func testIntMappingPerformance() {
        self.measureBlock {
            for _ in 0..<100_000 {
                let _ = try! UInt(json: 702888806)
            }
        }
    }
    
    func testUIntMappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt(json: json["ui"]))
    }
    
    
    func testUInt64MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt64(json: json["ui64"]))
    }
    
    func testUInt32MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt32(json: json["ui32"]))
    }
    
    func testUInt16MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt16(json: json["ui16"]))
    }
    
    func testUInt8MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try UInt8(json: json["ui8"]))
    }
    
}
