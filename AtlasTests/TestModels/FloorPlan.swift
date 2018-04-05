//
//  FloorPlan.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/7/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

import Foundation

import Atlas

struct FloorPlan {

    let name: String?
    let photos: [Photo]?
    let sqft: Int?
    let beds: Int?
    let baths: Int?

}

extension FloorPlan: AtlasMap {

    func toJSON() -> JSON? {
        return nil
    }

    init?(json: JSON) throws {
        do {
            let map = try Atlas(json)
            name = try map.object(forOptional: "name")
            photos = try map.array(forOptional: "photos")
            sqft = try map.object(forOptional: "sqft")
            beds = try map.object(forOptional: "beds")
            baths = try map.object(forOptional: "baths")
        } catch let error {
            throw error
        }
    }
}
