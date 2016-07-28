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

public class AtlasMappingExecutor: AtlasMapExecutor {
    
    public init() {
        
    }
    
    public func object<T: AtlasMap>(object: [String: JSON]?) throws -> T? {
        guard let unwrappedVal = object else {
            throw MappingError.GenericMappingError
        }
        
        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.NotMappable("Unable to map \(object) to type \(T.self)")
        }
        
        return mappedObject
    }
    
    public func array<T: AtlasMap>(array: [JSON]?) throws -> [T]? {
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
    
    public func objectFromKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> T {
        guard let unwrappedVal = object?[key] else {
            throw MappingError.KeyNotInJSONError("Mapping to \(T.self) failed. \(key) is not in the JSON object provided.")
        }
        
        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.NotMappable(".\(key) - Unable to map \(object) to type \(T.self)")
        }
        
        return mappedObject
    }
    
    public func arrayFromKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> [T] {
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
    
    public func objectFromOptionalKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> T? {
        guard let unwrappedVal = object?[key] else {
            return nil
        }
        
        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.NotMappable(".\(key) - Unable to map \(object) to type \(T.self)")
        }
        
        return mappedObject
    }
    
    public func arrayFromOptionalKey<T: AtlasMap>(key: String, withinJSONObject object: [String: JSON]?) throws -> [T]? {
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
    
}
