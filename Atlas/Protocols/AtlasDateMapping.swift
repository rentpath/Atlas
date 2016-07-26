//
//  AtlasDateMapper.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/25/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

public protocol AtlasDateMapping {
    func mapToRFC3339Date() throws -> NSDate?
    func mapToDateWithFormat(format: String) throws -> NSDate?
}