//
//  AtlasJSONArrayTests.swift
//  Atlas
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import XCTest
@testable import Atlas

class AtlasJSONArrayTests: XCTestCase {

    func testJSONDictionaryParsing() {
        let users: [User]
        do {
            users = try Atlas(TestJSON.jsonArray).toArrayOf(User)!
        } catch let e {
            XCTFail("Mapping error occurred: \(e)")
            return
        }
        
        XCTAssertTrue(users.first!.firstName == TestJSON.jsonDictionary["first_name"] as? String)
        XCTAssertTrue(users.first!.lastName == TestJSON.jsonDictionary["last_name"] as? String)
        XCTAssertTrue(users.first!.email == TestJSON.jsonDictionary["email"] as? String)
        XCTAssertTrue(users.first!.phone == TestJSON.jsonDictionary["phone"] as? Int)
        XCTAssertTrue(users.first!.avatarURL == TestJSON.jsonDictionary["avatar"] as? String)
        XCTAssertTrue(users.first!.isActive == TestJSON.jsonDictionary["is_active"] as? Bool)
        let date = NSDate.dateFromRFC3339String(TestJSON.jsonDictionary["member_since"] as! String)
        XCTAssertTrue(users.first!.memberSince == date)
    }
    
    func testPerformanceExample() {
        self.measureBlock {
            do {
                try Atlas(TestJSON.jsonArray).toArrayOf(User)
            } catch let e {
                XCTFail("Mapping error occurred: \(e)")
            }
        }
    }

}
