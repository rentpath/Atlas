//
//  TestJSON.swift
//  Atlas
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

struct TestJSON {

    static let address: [String: Any] = [
        "number": 123,
        "street": "Main St",
        "city": "Atlanta",
        "state": "GA",
        "zip": "12345"
    ]

    static let floorplans: [Any] = [
        fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan, fplan
    ]

    static let photos: [Any] = [
        photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo
    ]

    static let user: [String: Any] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": 223344,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000",
        "address": address,
        "floorplans": floorplans,
        "photos": photos

    ]

    static let users: [[String: Any]] = [
        user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user, user
    ]

    static let fplan: [String: Any] = [
        "name": "Foo",
        "photos": photos,
        "sqft": 2345,
        "beds": 2,
        "baths": 1
    ]

    static let photo: [String: Any] = [
        "abstract": "Something about this photo...",
        "url": "/img/shdhiwieo9weoidifhowedhdw/"
    ]

    static let userMissingKey: [String: Any] = [
        "first_name": "John",
        "last_name": "Appleseed",
/*>>>   "email": "john@test.com", Removed for test */
        "phone": 1114445555,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000",
        "address": address,
        "floorplans": floorplans,
        "photos": photos
    ]

    static let userInvalidValueKey: [String: Any] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": 1114445555,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
/*>>>*/ "is_active": "true", // Changed to "true" for a test
        "member_since": "2016-01-30T09:19:52.000",
        "address": address,
        "floorplans": floorplans,
        "photos": photos
    ]

    static let jsonDictionaryDifferentType: [String: Any] = [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": "2223334444", // Change value to a String for test
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000",
        "address": address,
        "floorplans": floorplans,
        "photos": photos
    ]

    static let jsonArray: [Any] = [
        user, user, user
    ]

    static let jsonArrayMissingKey: [Any] = [
        userMissingKey, user, user
    ]

    static let jsonArrayDifferentType: [Any] = [
        jsonDictionaryDifferentType, user, user
    ]

}
