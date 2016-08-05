//
//  AtlasTests.swift
//  AtlasTests
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import XCTest
#if os(tvOS)
    @testable import AtlasTV
#else
    @testable import Atlas
#endif

class AtlasJSONDictionaryTests: XCTestCase {
    
    func testJSONDictionaryParsing() {
        let user: User
        do {
            user = try Atlas(TestJSON.user).object()!
        } catch let e {
            XCTFail("Unexpected Mapping error occurred: \(e)")
            return
        }
        
        XCTAssertTrue(user.firstName == TestJSON.user["first_name"] as? String)
        XCTAssertTrue(user.lastName == TestJSON.user["last_name"] as? String)
        XCTAssertTrue(user.email == TestJSON.user["email"] as? String)
        XCTAssertTrue(user.phone == TestJSON.user["phone"] as? Int)
        XCTAssertTrue(user.avatarURL == TestJSON.user["avatar"] as? String)
        XCTAssertTrue(user.isActive == TestJSON.user["is_active"] as? Bool)
        let date = NSDate.dateFromRFC3339String(TestJSON.user["member_since"] as! String)
        XCTAssertTrue(user.memberSince == date)
    }
    
    func testInvalidValueErrorHandling() {
        var user: User?
        XCTAssertThrowsError(user = try Atlas(TestJSON.userInvalidValueKey).object())
        XCTAssertNil(user)
    }
    
    func testKeyNotInJSONErrorHandling() {
        var user: User?
        XCTAssertThrowsError(user = try Atlas(TestJSON.userMissingKey).object())
        XCTAssertNil(user)
    }
    
    // Disabled due to massive changes within Atlas that make it no longer able to return an error if the type doesn't match. Instead, an error will only be thrown if a mapping fails, not if a type in the JSON doesn't match the type being mapped to.
    func DISABLED_testNotMappableErrorHandling() {
        var message: String?
        var user: User?
        do {
            user = try Atlas(TestJSON.jsonDictionaryDifferentType).object()
        } catch let e as MappingError {
            switch e {
            case let .NotMappable(_message):
                message = "User\(_message)"
            default:
                XCTFail("Unexpected Mapping error occurred: \(e)")
                return
            }
        } catch let e as NSError {
            XCTFail("Unexpected error occurred: \(e)")
            return
        }
        
        XCTAssert(user == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message == "User.phone - Unable to map 2223334444 to type Int", "Error handling didn't return the proper error message. Received: \(message)")
    }
    
    func testNoMappingKeyProvidedInModelErrorHandling() {
        var message: String?
        var user: UserNoKey?
        do {
            user = try Atlas(TestJSON.user).object()
        } catch let e as MappingError {
            switch e {
            case let .KeyNotInJSONError(_message):
                message = "User\(_message)"
            default:
                XCTFail("Unexpected Mapping error occurred: \(e)")
                return
            }
        } catch let e as NSError {
            XCTFail("Unexpected error occurred: \(e)")
            return
        }
        
        XCTAssert(user == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message != "Mapping to String failed. foo is not in the JSON object provided.", "Error handling didn't return the proper error message")
    }
    
    func testPerformanceExample() {
        let before = NSDate()
        self.measureBlock {
            do {
                let _: [User] = try Atlas(TestJSON.users).array()!
            } catch let e {
                XCTFail("Unexpected Mapping error occurred: \(e)")
            }
        }
        print("Time: \(NSDate().timeIntervalSinceDate(before))")
    }
}
