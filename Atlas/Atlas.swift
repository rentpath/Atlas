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

import Foundation

open class Atlas {

    static fileprivate let internalExecutor: AtlasMappingExecutor = {
        let executor = AtlasMappingExecutor()
        return executor
    }()
    var executor: AtlasMapExecutor!
    var jsonArray: [JSON]!
    var jsonObject: [String: JSON]!

    /**
     Designated initializer that accepts JSON
     
     - Parameter json: A JSON object/array. Use NSJSONSerialization to get the JSON object/array from NSData and then pass the value into Atlas.
     */
    required public init(_ json: JSON, executor: AtlasMapExecutor? = nil) throws {
        self.executor = executor ?? Atlas.internalExecutor
        switch json {
        case let o as [String: JSON]: // swiftlint:disable:this switch_case_on_newline
            jsonObject = o.cleaned()
        case let a as [Any]:
            jsonArray = a
        default:
            throw MappingError.notAJSONObjectError
        }
    }

    /////////////////////////////////////////////////////
    // MARK: - Top level object mapping - key not required
    /////////////////////////////////////////////////////

    open func object<T: AtlasMap>() throws -> T? {
        do {
            return try executor.object(jsonObject)
        } catch {
            throw error
        }
    }

    open func array<T: AtlasMap>() throws -> [T]? {
        do {
            return try executor.array(jsonArray)
        } catch {
            throw error
        }
    }

    /////////////////////////////////////////////////////
    // MARK: - Required Sub-object mapping - key required
    /////////////////////////////////////////////////////

    open func object<T: AtlasMap>(for key: String) throws -> T {
        do {
            return try executor.object(for: key, from: jsonObject)
        } catch {
            throw error
        }
    }

    open func array<T: AtlasMap>(for key: String) throws -> [T] {
        do {
            return try executor.array(for: key, from: jsonObject)
        } catch {
            throw error
        }
    }

    /////////////////////////////////////////////////////
    // MARK: - Optional Sub-object mapping - key required
    /////////////////////////////////////////////////////

    open func object<T: AtlasMap>(forOptional key: String) throws -> T? {
        do {
            return try executor.object(forOptional: key, from: jsonObject)
        } catch {
            throw error
        }
    }

    open func array<T: AtlasMap>(forOptional key: String) throws -> [T]? {
        do {
            return try executor.array(forOptional: key, from: jsonObject)
        } catch {
            throw error
        }
    }

    /////////////////////////////////////////////////////
    // MARK: - Date mapping - key required
    /////////////////////////////////////////////////////

    open func date(for key: String, to format: Date.DateFormat) throws -> Date? {
        do {
            return try executor.dateMappingExecutor?.date(for: key, to: format, from: jsonObject)
        } catch {
            throw error
        }
    }

    /////////////////////////////////////////////////////
    // MARK: - Date mapping - key not required
    /////////////////////////////////////////////////////

    open func date(forOptional key: String, to format: Date.DateFormat) throws -> Date? {
        do {
            return try executor.dateMappingExecutor?.date(forOptional: key, to: format, from: jsonObject)
        } catch {
            throw error
        }
    }

}
