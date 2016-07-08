//
//  User.swift
//  Atlas
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import Foundation

#if os(tvOS)
    import AtlasTV
#else
    import Atlas
#endif
    
struct User {
    
    let firstName: String?
    let lastName: String?
    let email: String
    let phone: Int?
    let avatarURL: String?
    let isActive: Bool
    let memberSince: NSDate?
    let address: Address?
    let photos: [Photo]?
    let floorPlans: [FloorPlan]?
    
}

extension User: AtlasMap {
    
    func toJSON() -> JSON? {
        return nil
    }
    
    init?(json: JSON) throws {
        do {
            let map = try Atlas(json)
            firstName = try map.objectFromOptionalKey("first_name")
            lastName = try map.objectFromOptionalKey("last_name")
            email = try map.objectFromKey("email")
            phone = try map.objectFromOptionalKey("phone")
            avatarURL = try map.objectFromOptionalKey("avatar")
            isActive = try map.objectFromKey("is_active")
            memberSince = try map.dateFromOptionalKey("member_since", usingFormat: .RFC3339)
            address = try map.objectFromOptionalKey("address")
            photos = try map.arrayFromOptionalKey("photos")
            floorPlans = try map.arrayFromOptionalKey("floorplans")
        } catch let e {
            throw e
        }
    }
    
}


//////////////////////////////////


struct UserNoKey {
    
    let firstName: String?
    let lastName: String?
    let email: String
    let phone: Int?
    let avatarURL: String?
    let isActive: Bool
    let memberSince: NSDate?
    
}

extension UserNoKey: AtlasMap {
    
    func toJSON() -> JSON? {
        return nil
    }
    
    init?(json: JSON) throws {
        do {
            let map = try Atlas(json)
            firstName = try map.objectFromOptionalKey("first_name")
            lastName = try map.objectFromOptionalKey("last_name")
            email = try map.objectFromKey("foo") // foo is not a valid key in user json, this is for a test
            phone = try map.objectFromOptionalKey("phone")
            avatarURL = try map.objectFromOptionalKey("avatar")
            isActive = try map.objectFromKey("is_active")
            memberSince = try map.dateFromOptionalKey("member_since", usingFormat: .RFC3339)
        } catch let e {
            throw e
        }
    }
    
}
