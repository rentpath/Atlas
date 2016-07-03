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
            user = try Atlas(TestJSON.jsonDictionary).to(User)!
        } catch let e {
            XCTFail("Unexpected Mapping error occurred: \(e)")
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
    
    func testKeyNotInJSONErrorHandling() {
        var message: String?
        var user: User?
        do {
            user = try Atlas(TestJSON.jsonDictionaryMissingKey).to(User)!
        } catch let e as MappingError {
            switch e {
            case let .KeyNotInJSONError(_message):
                message = _message
            default:
                XCTFail("Unexpected Mapping error occurred: \(e)")
                return
            }
        } catch let e as NSError {
            XCTFail("Unexpected error occurred: \(e)")
            return
        }
        
        XCTAssert(user == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message == "Mapping to Int failed. phone is not in the JSON object provided.", "Error handling didn't return the proper error message")
    }
    
    func testNotMappableErrorHandling() {
        var message: String?
        var user: User?
        do {
            user = try Atlas(TestJSON.jsonDictionaryDifferentType).to(User)!
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
        XCTAssert(message == "User.phone - Unable to map 2223334444 to type Int", "Error handling didn't return the proper error message")
    }
    
    func testNoMappingKeyProvidedInModelErrorHandling() {
        var message: String?
        var user: UserNoKey?
        do {
            user = try Atlas(TestJSON.jsonDictionary).to(UserNoKey)!
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
        XCTAssert(message == "User.NoKey - Unable to map {\n    avatar = \"https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg\";\n    email = \"john@test.com\";\n    \"first_name\" = John;\n    \"is_active\" = 1;\n    \"last_name\" = Appleseed;\n    \"member_since\" = \"2016-01-30T09:19:52.000\";\n    phone = 2223334444;\n} to type String", "Error handling didn't return the proper error message")
    }
    
    func testPerformanceExample() {
        self.measureBlock {
            do {
                try Atlas(TestJSON.jsonDictionary).to(User)
            } catch let e {
                XCTFail("Unexpected Mapping error occurred: \(e)")
            }
        }
    }
}
