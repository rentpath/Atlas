//
//  User.swift
//  Atlas
//
//  Created by Jeremy Fox on 3/30/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import Foundation

import Atlas

struct User {

    let firstName: String?
    let lastName: String?
    let email: String
    let phone: Int?
    let avatarURL: String?
    let isActive: Bool
    let memberSince: Date?
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
            firstName = try map.object(forOptional: "first_name")
            lastName = try map.object(forOptional: "last_name")
            email = try map.object(for: "email")
            phone = try map.object(forOptional: "phone")
            avatarURL = try map.object(forOptional: "avatar")
            isActive = try map.object(for: "is_active")
            memberSince = try map.date(for: "member_since", to: .rfc3339)
            address = try map.object(forOptional: "address")
            photos = try map.array(forOptional: "photos")
            floorPlans = try map.array(forOptional: "floorplans")
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
    let memberSince: Date?

}

extension UserNoKey: AtlasMap {

    func toJSON() -> JSON? {
        return nil
    }

    init?(json: JSON) throws {
        do {
            let map = try Atlas(json)
            firstName = try map.object(forOptional: "first_name")
            lastName = try map.object(forOptional: "last_name")
            email = try map.object(for: "foo") // foo is not a valid key in user json, this is for a test
            phone = try map.object(forOptional: "phone")
            avatarURL = try map.object(forOptional: "avatar")
            isActive = try map.object(for: "is_active")
            memberSince = try map.date(for: "member_since", to: .rfc3339)
        } catch let e {
            throw e
        }
    }

}
