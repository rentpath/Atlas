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

class AtlasMappingExecutor: AtlasMapExector {
    
    func object<T: AtlasMap>(object: [String: JSON]?) throws -> T? {
        guard let unwrappedVal = object else {
            throw MappingError.GenericMappingError
        }
        
        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.NotMappable("Unable to map \(object) to type \(T.self)")
        }
        
        return mappedObject
    }
    
    func array<T: AtlasMap>(array: [JSON]?) throws -> [T]? {
        guard let unwrappedArray = array else {
            throw MappingError.NotAnArray
        }
        
        var array = [T]()
        for obj in unwrappedArray {
            guard let mappedObj = try T.init(json: obj) else {
                throw MappingError.NotMappable("Unable to map \(array) to type \(T.self)")
            }
            
            array.append(mappedObj)
        }
        
        return array
    }
    
    func objectFromKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> T {
        guard let unwrappedVal = object?[key] else {
            throw MappingError.KeyNotInJSONError("Mapping to \(T.self) failed. \(key) is not in the JSON object provided.")
        }
        
        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.NotMappable(".\(key) - Unable to map \(object) to type \(T.self)")
        }
        
        return mappedObject
    }
    
    func arrayFromKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> [T] {
        guard let _array = object?[key] else {
            throw MappingError.KeyNotInJSONError("Mapping to \(T.self) failed. \(key) is not in the JSON object provided.")
        }
        
        guard let __array = _array as? [JSON] else {
            throw MappingError.NotAnArray
        }
        
        var array = [T]()
        for obj in __array {
            guard let mappedObj = try T.init(json: obj) else {
                throw MappingError.NotMappable(".\(key) - Unable to map \(array) to type \(T.self)")
            }
            
            array.append(mappedObj)
        }
        
        return array
    }
    
    func objectFromOptionalKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> T? {
        guard let unwrappedVal = object?[key] else {
            return nil
        }
        
        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.NotMappable(".\(key) - Unable to map \(object) to type \(T.self)")
        }
        
        return mappedObject
    }
    
    func arrayFromOptionalKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> [T]? {
        guard let _array = object?[key] else {
            return nil
        }
        
        guard let __array = _array as? [JSON] else {
            throw MappingError.NotAnArray
        }
        
        var array = [T]()
        for obj in __array {
            guard let mappedObj = try T.init(json: obj) else {
                throw MappingError.NotMappable(".\(key) - Unable to map \(array) to type \(T.self)")
            }
            
            array.append(mappedObj)
        }
        
        return array
    }
    
    
    
    
    
    /**
     
     A type you would like the JSON value to be converted, this could be a 'primitive' or a model type
     
     - Parameters type: Type you would like the JSON value to be converted to
     
     - Throws: If `-key:` method was used, a `MappingError` may be thrown if the type cannot be converted or key does not exists
     
     - Returns: An Optional `T`
     
     */
//    func executeObjectMapping<T: AtlasMap>() throws -> T? {
//        var __jsonObject: JSON?
//        
//        if let _key = key {
//            if let _jsonObject = jsonObject?[_key] {
//                __jsonObject = _jsonObject
//            }
//            
//            if __jsonObject == nil && !keyIsOptional {
//                throw MappingError.KeyNotInJSONError("Mapping to \(T.self) failed. \(_key) is not in the JSON object provided.")
//            }
//        } else {
//            __jsonObject = jsonObject
//        }
//        
//        guard let unwrappedVal = __jsonObject else {
//            if keyIsOptional {
//                return nil
//            } else {
//                throw MappingError.GenericMappingError
//            }
//        }
//        
//        guard let mappedObject = try T.init(json: unwrappedVal) else {
//            throw MappingError.NotMappable(".\(key ?? "NoKey") - Unable to map \(jsonObject) to type \(T.self)")
//        }
//        
//        return mappedObject
//    }
    
    /**
     
     A array of type you would like the JSON array value to be converted, this could be a 'primitive' or a model type
     
     - Parameters type: Type you would like the JSON array value to be converted
     
     - Throws: If `-key:` method was used, a `MappingError` may be thrown if the type cannot be converted or key does not exists
     
     - Returns: An Optional array of `T`
     
     */
//    func executeArrayMapping<T: AtlasMap>() throws -> [T]? {
//        var __jsonArray: [JSON]? = jsonArray
//        
//        if let _key = key {
//            if let _jsonArray = jsonObject?[_key] {
//                __jsonArray = _jsonArray as? [JSON]
//            }
//            
//            if __jsonArray == nil && !keyIsOptional {
//                throw MappingError.KeyNotInJSONError("While trying to map the value of \(_key) in the provided JSON to type \(T.self), we found that the key is not isn the JSON object provided.")
//            }
//        }
//        
//        guard let unwrappedArray = __jsonArray else {
//            if keyIsOptional {
//                return nil
//            } else {
//                throw MappingError.NotAnArray
//            }
//        }
//        
//        var array = [T]()
//        for obj in unwrappedArray {
//            guard let mappedObj: T = try T.init(json: obj) else {
//                throw MappingError.NotMappable(".\(key ?? "NoKey") - Unable to map \(jsonArray) to type \(T.self)")
//            }
//            
//            array.append(mappedObj)
//        }
//        
//        return array
//    }
    
}
