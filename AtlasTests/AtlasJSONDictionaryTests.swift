//
//  AtlasTests.swift
//  AtlasTests
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import XCTest
@testable import Atlas

class AtlasJSONDictionaryTests: XCTestCase {
    
    func testJSONDictionaryParsing() {
        let user: User
        do {
            user = try Atlas(TestJSON.jsonDictionary).to(User)!
        } catch let e {
            XCTFail("Mapping error occurred: \(e)")
            return
        }
        
        XCTAssertTrue(user.firstName == TestJSON.jsonDictionary["first_name"] as? String)
        XCTAssertTrue(user.lastName == TestJSON.jsonDictionary["last_name"] as? String)
        XCTAssertTrue(user.email == TestJSON.jsonDictionary["email"] as? String)
        XCTAssertTrue(user.phone == TestJSON.jsonDictionary["phone"] as? Int)
        XCTAssertTrue(user.avatarURL == TestJSON.jsonDictionary["avatar"] as? String)
        XCTAssertTrue(user.isActive == TestJSON.jsonDictionary["is_active"] as? Bool)
        let date = NSDate.dateFromRFC3339String(TestJSON.jsonDictionary["member_since"] as! String)
        XCTAssertTrue(user.memberSince == date)
    }
    
    func testPerformanceExample() {
        self.measureBlock {
            do {
                try Atlas(TestJSON.jsonDictionary).to(User)
            } catch let e {
                XCTFail("Mapping error occurred: \(e)")
            }
        }
    }
    
}
