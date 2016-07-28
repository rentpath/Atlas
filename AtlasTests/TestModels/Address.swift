//
//  Address.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/7/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import Foundation

#if os(tvOS)
    import AtlasTV
#else
    import Atlas
#endif

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
            number = try map.objectFromOptionalKey("number")
            street = try map.objectFromOptionalKey("street")
            city = try map.objectFromOptionalKey("city")
            state = try map.objectFromOptionalKey("state")
            zip = try map.objectFromOptionalKey("zip")
        } catch let e {
            throw e
        }
    }
}
