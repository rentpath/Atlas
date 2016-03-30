// Copyright 2016 RentPath
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

public class Atlas {
    
    private var _json: JSON
    private var _key: String?
    private var _keyIsOptional = false
    private var _forceTo = false
    
    /**
     
     convenient initializer that accepts JSON string
     
     - Parameters json: JSON String
     
     */
    
    public init(_ json: JSON) throws {
        switch json {
        case let o as [String: AnyObject]:
            _json = o.cleaned()
        case let a as [AnyObject]:
            _json = a.filter { $0 != nil && !($0 is NSNull) }
        default:
            // Any individual object, String, Int, Bool, etc...
            _json = json
        }
    }
    
    /**
     
     Accepts the key name you would like to map to model field
     
     - Parameters key: The string that represents the key in the JSON object.
     
     - Throws: Can throw a `MappingError` if `key` doesn't exist in `fromJSON`
     
     - Returns: RPMapper object for a fluent interface
     
     */
    public func key(key: String) -> Self {
        _keyIsOptional = false
        _key = key
        return self
    }
    
    /**
     
     Accept the `optional` key name you would like to map to the model. If the key does not exists no `MappingError` will be thrown
     
     - Parameters key: The string that represents the key in the JSON object.

     - Returns: RPMapper object for a fluent interface
     
     */
    public func optionalKey(key: String) -> Self {
        _keyIsOptional = true
        _key = key
        return self
    }
    
    
    /**
    
     Oh, were you thinking about using this? Really? NOOOO! Don't do it!, Stay away. Stay far far away!
     
     Andre, is watching you!
     
     */
    public func forceTo<T>(type: T.Type) throws -> T? {
        _forceTo = true
        let result: T?
        do {
             result = try to(type)
        } catch {
            throw error
        }
        
        _forceTo = false
        return result
    }
    
    /**
     
     A type you would like the JSON value to be converted, this could be a 'primitive' or a model type
     
     - Parameters type: Type you would like the JSON value to be converted
     
     - Throws: If `Key` method was used an `MappingError` may be thrown if the type cannot be converted or key does not exists
     
     - Returns: An Optional type object of the type you passed in
     
     */
    public func to<T>(type: T.Type) throws -> T? {
        let _val: AnyObject
        switch _json {
        case is [String: AnyObject]:
            var jsonObject: JSON? = _json
            
            if let __key = _key {
                if let _jsonObject = _json[__key] {
                    jsonObject = _jsonObject
                }
                
                if jsonObject == nil && !_keyIsOptional {
                    throw MappingError.KeyNotInJSONError("Mapping to \(type) failed. \(__key) is not in the JSON object provided.")
                }
            }
            
            guard let unwrappedVal = jsonObject else {
                if _keyIsOptional {
                    return nil
                } else {
                    throw MappingError.GenericMappingError
                }
            }

            _val = unwrappedVal
        default:
            _val = _json
        }
        
        do {
            let val = try map(_val, to: type)
            return val
        } catch let e as MappingError {
            throw e
        }
    }
    
    /**
     
     A array of type you would like the JSON array value to be converted, this could be a 'primitive' or a model type
     
     - Parameters type: Type you would like the JSON array value to be converted
     
     - Throws: If `Key` method was used an `MappingError` may be thrown if the type cannot be converted or key does not exists
     
     - Returns: An Optional array type object of the array type you passed in
     
     */
    public func toArrayOf<T>(type: T.Type) throws -> [T]? {
        var jsonArray: JSON? = _json
        
        if let __key = _key {
            if let _jsonArray = _json[__key] as? [AnyObject] {
                jsonArray = _jsonArray
            }
            
            if jsonArray == nil && !_keyIsOptional {
                throw MappingError.KeyNotInJSONError("While trying to map the value of \(__key) in the provided JSON to type \(type), we found that the key is not isn the JSON object provided.")
            }
        }
        
        guard let unwrappedArray = jsonArray as? [AnyObject] else {
            if _keyIsOptional {
                return nil
            } else {
                throw MappingError.GenericMappingError
            }
        }

        do {
            let array = try unwrappedArray.filter { $0 != nil && !($0 is NSNull) }.map { try map($0, to: type)! }
            return array
        } catch let e as MappingError {
            throw e
        }
    }
    
    /**
     
     Map a RFC3339 date from JSON to Model field
     
     - Throws: If `Key` method was not used an `MappingError` may be thrown, also a `MappingError` will be thrown if the value is not a string type
     
     - Returns: An Optional NSDate
     
     */
    public func toRFC3339Date() throws -> NSDate? {
        
        return try toDate("yyyy-MM-dd'T'HH:mm:ss.S'Z'")
    }
    
    /**
     
     Map a date from JSON to Model field with a given date format string
     
     - Parameters format: string representation of the date format
     
     - Throws: If `Key` method was not used an `MappingError` may be thrown, also a `MappingError` will be thrown if the value is not a string type
     
     - Returns: An Optional NSDate
     
     */
    public func toDate(format: String) throws -> NSDate? {
        guard let key = _key else {
            if _keyIsOptional {
                return nil
            } else {
                throw MappingError.NoKeyError
            }
        }
        
        guard let _val = _json[key] as? String where !_val.isEmpty else {

            if _keyIsOptional {
                return nil
            } else {
                throw MappingError.NotMappable("The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate.")
            }
        }
        
        if let _date = NSDate.dateFromString(_val, withFormat: format) {
            return _date
        } else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the format \(format)")
        }
    }
    
    func map<T>(val: AnyObject, to: T.Type) throws -> T? {
        let retVal: T?
        
        switch to {
        case is String.Type:
            if _forceTo {
                retVal = "\(val)" as? T
            } else {
                guard let _val = val as? String else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = "\(_val)" as? T
            }
        case is Int.Type:
            if _forceTo {
                retVal = Int(val.intValue) as? T
            } else {
                guard let _val = val as? Int else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is Int16.Type:
            if _forceTo {
                retVal = Int16(val.intValue) as? T
            } else {
                guard let _val = val as? Int16 else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is Int32.Type:
            if _forceTo {
                retVal = Int32(val.longValue) as? T
            } else {
                guard let _val = val as? Int32 else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is Int64.Type:
            if _forceTo {
                retVal = Int64(val.longLongValue) as? T
            } else {
                guard let _val = val as? Int64 else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is Float.Type:
            if _forceTo {
                retVal = Float(val.floatValue) as? T
            } else {
                guard let _val = val as? Float else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is Double.Type:
            if _forceTo {
                retVal = Double(val.doubleValue) as? T
            } else {
                guard let _val = val as? Double else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is Bool.Type:
            if _forceTo {
                retVal = val.boolValue as? T
            } else {
                guard let _val = val as? Bool else {
                    throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
                }
                retVal = _val as? T
            }
        case is AtlasMap.Type:
            if let _to = (to as? AtlasMap.Type) {
                do {
                    retVal = try _to.init(json: val) as? T
                } catch let e {
                    throw e
                }
            } else {
                throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
            }
        default:
            throw MappingError.NotMappable(".\(_key ?? "NoKey") - Unable to map \(val) to type \(to)")
        }
        
        _key = nil
        return retVal
    }
    
}
