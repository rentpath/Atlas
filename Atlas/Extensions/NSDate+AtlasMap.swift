//
//  NSDate+AtlasMap.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/25/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

extension NSDate: AtlasMap {
    
    public func toJSON() -> JSON? {
        return nil
    }
    
    public init?(json: JSON) {
        self = String(json)
    }
    
}
