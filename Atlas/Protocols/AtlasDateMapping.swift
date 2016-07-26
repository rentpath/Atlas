//
//  AtlasDateMapper.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/25/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

public protocol AtlasDateMapping {
    func mapKey(key: String) throws -> Self
    func mapOptionalKey(key: String) throws -> Self
    func toRFC3339Date() throws -> NSDate?
    func toDateWithFormat(format: String) throws -> NSDate?
}