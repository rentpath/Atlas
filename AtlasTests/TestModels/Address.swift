//
//  Address.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/7/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import Foundation

import Atlas

struct Address {

    let number: Int?
    let street: String?
    let city: String?
    let state: String?
    let zip: String?

}

extension Address: AtlasMap {

    func toJSON() -> JSON? {
        return nil
    }

    init?(json: JSON) throws {
        do {
            let map = try Atlas(json)
            number = try map.object(forOptional: "number")
            street = try map.object(forOptional: "street")
            city = try map.object(forOptional: "city")
            state = try map.object(forOptional: "state")
            zip = try map.object(forOptional: "zip")
        } catch let e {
            throw e
        }
    }
}
