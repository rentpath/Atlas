//
//  TestJSON.swift
//  Atlas
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

struct TestJSON {
    
    static let user: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": 223344,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000",
        "address": [
            "number": 123,
            "street": "Main St",
            "city": "Atlanta",
            "state": "GA",
            "zip": "12345"
        ],
        "floorplans": [
            fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan
        ],
        "photos": [
            photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo
        ]
    ]
    
    static let users: [[String: AnyObject]] = [
        user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user
    ]
    
    static let fplan: [String: AnyObject] = [
        "name": "Foo",
        "photos": [
            photo, photo, photo, photo, photo, photo, photo
        ],
        "sqft": 2345,
        "beds": 2,
        "baths": 1
    ]
    
    static let photo: [String: AnyObject] = [
        "abstract": "Something about this photo...",
        "url": "/img/shdhiwieo9weoidifhowedhdw/"
    ]
    
    static let userMissingKey: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
/*>>>   "email": "john@test.com", Removed for test */
        "phone": 1114445555,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000",
        "address": [
            "number": 123,
            "street": "Main St",
            "city": "Atlanta",
            "state": "GA",
            "zip": "12345"
        ],
        "floorplans": [
            fplan
        ],
        "photos": [
            photo
        ]
    ]
    
    static let userInvalidValueKey: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": 1114445555,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
/*>>>*/ "is_active": "true", // Changed to "true" for a test
        "member_since": "2016-01-30T09:19:52.000",
        "address": [
            "number": 123,
            "street": "Main St",
            "city": "Atlanta",
            "state": "GA",
            "zip": "12345"
        ],
        "floorplans": [
            fplan
        ],
        "photos": [
            photo
        ]
    ]
    
    static let jsonDictionaryDifferentType: [String: AnyObject] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": "2223334444", // Change value to a String for test
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000",
        "address": [
            "number": 123,
            "street": "Main St",
            "city": "Atlanta",
            "state": "GA",
            "zip": "12345"
        ],
        "floorplans": [
            fplan
        ],
        "photos": [
            photo
        ]
    ]
    
    static let jsonArray: [AnyObject] = [
        user, user, user
    ]
    
    static let jsonArrayMissingKey: [AnyObject] = [
        userMissingKey, user, user
    ]
    
    static let jsonArrayDifferentType: [AnyObject] = [
        jsonDictionaryDifferentType, user, user
    ]
    
}
