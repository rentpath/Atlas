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

open class AtlasMappingExecutor: AtlasMapExecutor {

    

    public init() {

    }
    public func dicArray<T, U>(forOptional key: String, from json: [String : JSON]?) throws -> [U : [T]]? where T : AtlasMap, U : AtlasMap, U : Hashable {
        guard let unwrappedVal = json?[key] as? [String: [JSON]] else {
         return nil
        }
        var dictObj = [U:[T]]()
        for (value,dict) in unwrappedVal  {
            var array = [T]()
            print(value)
            print(dict)
            guard let valueObj = try U.init(json: value) else {
                throw MappingError.notMappable(".\(key) - Unable to map  to type \(T.self)")
            }
            for obj in dict {
                guard let mappedObj = try T.init(json: obj) else {
                    throw MappingError.notMappable(".\(key) - Unable to map  to type \(T.self)")
                }

                array.append(mappedObj)
            }
            dictObj[valueObj] = array
        }
        print(unwrappedVal)
        return dictObj
    }

    open func object<T: AtlasMap>(_ object: [String: JSON]?) throws -> T? {
        guard let unwrappedVal = object else {
            throw MappingError.genericMappingError
        }

        guard let mappedObject = try T.init(json: unwrappedVal as JSON) else {
            throw MappingError.notMappable("Unable to map \(String(describing: object)) to type \(T.self)")
        }

        return mappedObject
    }

    open func array<T: AtlasMap>(_ array: [JSON]?) throws -> [T]? {
        guard let unwrappedArray = array else {
            throw MappingError.notAnArray
        }

        var array = [T]()
        for obj in unwrappedArray {
            guard let mappedObj = try T.init(json: obj) else {
                throw MappingError.notMappable("Unable to map \(array) to type \(T.self)")
            }

            array.append(mappedObj)
        }

        return array
    }

    open func object<T: AtlasMap>(for key: String, from json: [String: JSON]?) throws -> T {
        guard let unwrappedVal = json?[key] else {
            throw MappingError.keyNotInJSONError("Mapping to \(T.self) failed. \(key) is not in the JSON object provided.")
        }

        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.notMappable(".\(key) - Unable to map \(String(describing: json)) to type \(T.self)")
        }

        return mappedObject
    }

    open func array<T: AtlasMap>(for key: String, from json: [String: JSON]?) throws -> [T] {
        guard let unwrappedArray = json?[key] else {
            throw MappingError.keyNotInJSONError("Mapping to \(T.self) failed. \(key) is not in the JSON object provided.")
        }

        guard let validatedArray = unwrappedArray as? [JSON] else {
            throw MappingError.notAnArray
        }

        var array = [T]()
        for obj in validatedArray {
            guard let mappedObj = try T.init(json: obj) else {
                throw MappingError.notMappable(".\(key) - Unable to map \(unwrappedArray) to type \(T.self)")
            }

            array.append(mappedObj)
        }

        return array
    }

    open func object<T: AtlasMap>(forOptional key: String, from json: [String: JSON]?) throws -> T? {
        guard let unwrappedVal = json?[key] else {
            return nil
        }

        guard let mappedObject = try T.init(json: unwrappedVal) else {
            throw MappingError.notMappable(".\(key) - Unable to map \(String(describing: json)) to type \(T.self)")
        }

        return mappedObject
    }

    open func array<T: AtlasMap>(forOptional key: String, from json: [String: JSON]?) throws -> [T]? {
        guard let unwrappedArray = json?[key] else {
            return nil
        }

        guard let validatedArray = unwrappedArray as? [JSON] else {
            throw MappingError.notAnArray
        }

        var array = [T]()
        for obj in validatedArray {
            guard let mappedObj = try T.init(json: obj) else {
                throw MappingError.notMappable(".\(key) - Unable to map \(unwrappedArray) to type \(T.self)")
            }

            array.append(mappedObj)
        }

        return array
    }

}
