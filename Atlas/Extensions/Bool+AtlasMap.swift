//
//  Bool+AtlasMap.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/25/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

extension Bool: AtlasMap {
    
    public func toJSON() -> JSON? {
        return nil
    }
    
    public init?(json: JSON) throws {
        guard let _bool = json as? Bool else {
            return nil
        }
        self = _bool
    }
    
}
