//
//  Int+AtlasMapTests.swift
//  Atlas
//
//  Created by Jeremy Fox on 8/3/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import XCTest
#if os(tvOS)
    @testable import AtlasTV
#else
    @testable import Atlas
#endif

class Int_AtlasMapTests: XCTestCase {

    var json: JSON!
    
    override func setUp() {
        super.setUp()
        let i: Int = 702888806
        let i8: Int8 = 70
        let i16: Int16 = 7028
        let i32: Int32 = 702888806
        let i64: Int64 = 70288880664460
        let dict: [String: AnyObject] = [
            "i": NSNumber(long: i),
            "i8": NSNumber(char: i8),
            "i16": NSNumber(short: i16),
            "i32": NSNumber(int: i32),
            "i64": NSNumber(longLong: i64)
        ]
        let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
        json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
    }
    
    override func tearDown() {
        json = nil
        super.tearDown()
    }
    
    func testIntMappingMapsIntegerValuesWithinManAndMaxRange() {
        let min = Int.min
        let zero = 0
        let max = Int.max
        
        XCTAssertEqual(try! Int(json: min), Int.min)
        XCTAssertEqual(try! Int(json: zero), 0)
        XCTAssertEqual(try! Int(json: max), Int.max)
    }
    
    func testIntMappingPerformance() {
        self.measureBlock {
            for _ in 0..<100_000 {
                let _ = try! Int(json: 702888806)
            }
        }
    }
    
    func testIntMappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int(json: json["i"]))
    }
    
    
    func testInt64MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int64(json: json["i64"]))
    }
    
    func testInt32MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int32(json: json["i32"]))
    }
    
    func testInt16MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int16(json: json["i16"]))
    }
    
    func testInt8MappingThrowsErrorIfUnableToMap() {
        XCTAssertNotNil(try Int8(json: json["i8"]))
    }

}
