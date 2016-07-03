//
//  TestJSON.swift
//  Atlas
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

struct TestJSON {
    
    static let jsonDictionary: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": 2223334444,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000"
    ]
    
    static let jsonDictionaryMissingKey: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000"
    ]
    
    static let jsonDictionaryDifferentType: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": "2223334444",
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000"
    ]
    
    static let jsonArray: [AnyObject] = [
        jsonDictionary, jsonDictionary, jsonDictionary
    ]
    
    static let jsonArrayMissingKey: [AnyObject] = [
        jsonDictionaryMissingKey, jsonDictionary, jsonDictionary
    ]
    
    static let jsonArrayDifferentType: [AnyObject] = [
        jsonDictionaryDifferentType, jsonDictionary, jsonDictionary
    ]
    
}
