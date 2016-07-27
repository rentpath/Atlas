/*
 * Copyright (c) 2016 RentPath, LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

extension AtlasMappingExecutor: AtlasDateMapping {
    
    func dateFromRFC3339StringFromKey(key: String, withinJSONObject object: [String: JSON]?) throws -> NSDate? {
//        guard let key = key else {
//            throw MappingError.NoKeyError
//        }
        
        guard let _val = object?[key] as? String where !_val.isEmpty else {
            throw MappingError.NotMappable("The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate.")
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: .RFC3339) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format.")
        }
        
        return date
    }
    
    func dateFromRFC3339StringFromOptionalKey(key: String, withinJSONObject object: [String: JSON]?) throws -> NSDate? {
//        guard let key = key else {
//            throw MappingError.NoKeyError
//        }
        
        guard let _val = object?[key] as? String where !_val.isEmpty else {
            return nil
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: .RFC3339) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format.")
        }
        
        return date
    }
    
    func dateFromKey(key: String, toDateWithFormat format: String, withinJSONObject object: [String: JSON]?) throws -> NSDate? {
//        guard let key = key else {
//            throw MappingError.NoKeyError
//        }
        
        guard let _val = object?[key] as? String where !_val.isEmpty else {
            throw MappingError.NotMappable("The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate.")
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: .Custom(format)) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format.")
        }
        
        return date
    }
    
    func dateFromOptionalKey(key: String, toDateWithFormat format: String, withinJSONObject object: [String: JSON]?) throws -> NSDate? {
//        guard let key = key else {
//            throw MappingError.NoKeyError
//        }
        
        guard let _val = object?[key] as? String where !_val.isEmpty else {
            return nil
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: .Custom(format)) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format.")
        }
        
        return date
    }
    
    
    
    
    
    
    /**
     
     Map a RFC3339 date from JSON to Model field
     
     - Throws: If `Key` method was not used a `MappingError` may be thrown, also a `MappingError` will be thrown if the value is not a string type
     
     - Returns: An Optional NSDate
     
     */
//    func toRFC3339Date() throws -> NSDate? {
//        return try toDateWithFormat("yyyy-MM-dd'T'HH:mm:ss.S'Z'")
//    }
    
    /**
     
     Map a date from JSON to Model field with a given date format string
     
     - Parameters format: string representation of the date format
     
     - Throws: If `Key` method was not used an `MappingError` may be thrown, also a `MappingError` will be thrown if the value is not a string type
     
     - Returns: An Optional NSDate
     
     */
//    func toDateWithFormat(format: String) throws -> NSDate? {
//        guard let key = key else {
//            if keyIsOptional {
//                return nil
//            } else {
//                throw MappingError.NoKeyError
//            }
//        }
//        
//        guard let _val = jsonObject?[key] as? String where !_val.isEmpty else {
//            
//            if keyIsOptional {
//                return nil
//            } else {
//                throw MappingError.NotMappable("The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate.")
//            }
//        }
//        
//        guard let date = NSDate.dateFromString(_val, withFormat: .Custom(format)) else {
//            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the format \(format)")
//        }
//        
//        return date
//    }
//
    
}
