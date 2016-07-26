//
//  AtlasDateMapper.swift
//  Atlas
//
//  Created by Jeremy Fox on 7/25/16.
//  Copyright © 2016 RentPath. All rights reserved.
//

extension AtlasMappingExecutor: AtlasDateMapping {
    
    /**
     
     Map a RFC3339 date from JSON to Model field
     
     - Throws: If `Key` method was not used a `MappingError` may be thrown, also a `MappingError` will be thrown if the value is not a string type
     
     - Returns: An Optional NSDate
     
     */
    func mapToRFC3339Date() throws -> NSDate? {
        return try mapToDateWithFormat("yyyy-MM-dd'T'HH:mm:ss.S'Z'")
    }
    
    /**
     
     Map a date from JSON to Model field with a given date format string
     
     - Parameters format: string representation of the date format
     
     - Throws: If `Key` method was not used an `MappingError` may be thrown, also a `MappingError` will be thrown if the value is not a string type
     
     - Returns: An Optional NSDate
     
     */
    func mapToDateWithFormat(format: String) throws -> NSDate? {
        guard let key = key else {
            if keyIsOptional {
                return nil
            } else {
                throw MappingError.NoKeyError
            }
        }
        
        guard let _val = jsonObject?[key] as? String where !_val.isEmpty else {
            
            if keyIsOptional {
                return nil
            } else {
                throw MappingError.NotMappable("The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate.")
            }
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: format) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the format \(format)")
        }
        
        return date
    }

    
}
