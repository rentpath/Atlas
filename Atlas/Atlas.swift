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

public class Atlas {
    
    static private let _internalExecutor: AtlasMappingExecutor = {
        let executor = AtlasMappingExecutor()
        return executor
    }()
    var _executor: AtlasMapExector!
    var _jsonArray: [JSON]!
    var _jsonObject: [String: JSON]!
    
    /**
     Designated initializer that accepts JSON
     
     - Parameter json: A JSON object/array. Use NSJSONSerialization to get the JSON object/array from NSData and then pass the value into Atlas.
     */
    required public init(_ json: JSON, executor: AtlasMapExector? = nil) throws {
        _executor = executor ?? Atlas._internalExecutor
        switch json {
        case let o as [String: JSON]:
            _jsonObject = o.cleaned()
        case let a as [AnyObject]:
            _jsonArray = a
        default:
            throw MappingError.NotAJSONObjectError
        }
    }
    
    /////////////////////////////////////////////////////
    //MARK: Top level object mapping - key not required
    /////////////////////////////////////////////////////
    
    public func object<T: AtlasMap>() throws -> T? {
        do {
            return try _executor.object(_jsonObject)
        } catch {
            throw error
        }
    }
    
    public func array<T: AtlasMap>() throws -> [T]? {
        do {
            return try _executor.array(_jsonArray)
        } catch {
            throw error
        }
    }
    
    /////////////////////////////////////////////////////
    //MARK: Required Sub-object mapping - key required
    /////////////////////////////////////////////////////
    
    public func objectFromKey<T: AtlasMap>(key: String) throws -> T {
        do {
            return try _executor.objectFromKey(key, withinJSONObject: _jsonObject)
        } catch {
            throw error
        }
    }
    
    
    public func arrayFromKey<T: AtlasMap>(key: String) throws -> [T] {
        do {
            return try _executor.arrayFromKey(key, withinJSONObject: _jsonObject)
        } catch {
            throw error
        }
    }
    
    /////////////////////////////////////////////////////
    //MARK: Optional Sub-object mapping - key required
    /////////////////////////////////////////////////////
    
    public func objectFromOptionalKey<T: AtlasMap>(key: String) throws -> T? {
        do {
            return try _executor.objectFromOptionalKey(key, withinJSONObject: _jsonObject)
        } catch {
            throw error
        }
    }
    
    public func arrayFromOptionalKey<T: AtlasMap>(key: String) throws -> [T]? {
        do {
            return try _executor.arrayFromOptionalKey(key, withinJSONObject: _jsonObject)
        } catch {
            throw error
        }
    }
    
    /////////////////////////////////////////////////////
    //MARK: Date mapping - key required
    /////////////////////////////////////////////////////
    
    public func dateFromKey(key: String, usingFormat format: NSDate.DateFormat) throws -> NSDate? {
        do {
            return try _executor.dateMappingExecutor?.dateFromKey(key, toDateWithFormat: format, withinJSONObject: _jsonObject)
        } catch {
            throw error
        }
    }
    
    /////////////////////////////////////////////////////
    //MARK: Date mapping - key not required
    /////////////////////////////////////////////////////
    
    public func dateFromOptionalKey(key: String, usingFormat format: NSDate.DateFormat) throws -> NSDate? {
        do {
            return try _executor.dateMappingExecutor?.dateFromOptionalKey(key, toDateWithFormat: format, withinJSONObject: _jsonObject)
        } catch {
            throw error
        }
    }
    
}

