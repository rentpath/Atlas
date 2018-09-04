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
            users = try Atlas(TestJSON.jsonArray as JSON).array()!
        } catch let error {
            XCTFail("Mapping error occurred: \(error)")
            return
        }

        XCTAssertTrue(users.first!.firstName == TestJSON.user["first_name"] as? String)
        XCTAssertTrue(users.first!.lastName == TestJSON.user["last_name"] as? String)
        XCTAssertTrue(users.first!.email == TestJSON.user["email"] as? String)
        XCTAssertTrue(users.first!.phone == TestJSON.user["phone"] as? Int)
        XCTAssertTrue(users.first!.avatarURL == TestJSON.user["avatar"] as? String)
        XCTAssertTrue(users.first!.isActive == TestJSON.user["is_active"] as? Bool)
//        let date = NSDate.dateFromRFC3339String(TestJSON.user["member_since"] as! String)
//        XCTAssertTrue(users.first!.memberSince == date)
    }

    func testKeyNotInJSONErrorHandling() {
        var message: String?
        var user: [User]?
        do {
            user = try Atlas(TestJSON.jsonArrayMissingKey as JSON).array()
        } catch let error as MappingError {
            switch error {
            case let .keyNotInJSONError(_message):
                message = _message
            default:
                XCTFail("Unexpected Mapping error occurred: \(error)")
                return
            }
        } catch let error as NSError {
            XCTFail("Unexpected error occurred: \(error)")
            return
        }

        XCTAssert(user == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message == "Mapping to String failed. email is not in the JSON object provided.")
    }

    func DISABLED_testNotMappableErrorHandling() {
        var message: String?
        var users: [User]?
        do {
            users = try Atlas(TestJSON.jsonArrayDifferentType as JSON).array()
        } catch let error as MappingError {
            switch error {
            case let .notMappable(_message):
                message = "User\(_message)"
            default:
                XCTFail("Unexpected Mapping error occurred: \(error)")
                return
            }
        } catch let error as NSError {
            XCTFail("Unexpected error occurred: \(error)")
            return
        }

        XCTAssert(users == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message == "User.phone - Unable to map Optional(2223334444) to type Int", "Error handling didn't return the proper error message. Received: \(message ?? "")")
    }

    func testNoMappingKeyProvidedInModelErrorHandling() {
        var message: String?
        var user: [UserNoKey]?
        do {
            user = try Atlas(TestJSON.jsonArray as JSON).array()
        } catch let error as MappingError {
            switch error {
            case let .keyNotInJSONError(error):
                message = "User.\(error)"
            default:
                XCTFail("Unexpected Mapping error occurred: \(error)")
                return
            }
        } catch let error as NSError {
            XCTFail("Unexpected error occurred: \(error)")
            return
        }
        XCTAssert(user == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message == "User.Mapping to String failed. foo is not in the JSON object provided.", "Error handling didn't return the proper error message")
    }

    func testNotAnArrayErrorHandling() {
        var message: String?
        var user: [User]?
        do {
            user = try Atlas(TestJSON.user as JSON).array()
        } catch let error as MappingError {
            switch error {
            case .notAnArray:
                message = "NotAnArray"
            default:
                XCTFail("Unexpected Mapping error occurred: \(error)")
                return
            }
        } catch let error as NSError {
            XCTFail("Unexpected error occurred: \(error)")
            return
        }

        XCTAssert(user == nil, "Received a valid User instance even though the expectation was that JSON parsing would fail")
        XCTAssert(message == "NotAnArray", "Error handling didn't return the proper error message")
    }

    func testPerformanceExample() {
        self.measure {
            do {
                let _: [User]? = try Atlas(TestJSON.jsonArray as JSON).array()
            } catch let error {
                XCTFail("Mapping error occurred: \(error)")
            }
        }
    }

}
