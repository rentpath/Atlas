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

extension AtlasMappingExecutor: AtlasDateMappingExecutor {

    public var dateMappingExecutor: AtlasDateMappingExecutor? {
        return self
    }

    public func date(for key: String, to format: Date.DateFormat, from json: [String: JSON]?) throws -> Date? {
        guard let _val = json?[key] as? String, !_val.isEmpty else {
            let message = "The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate."
            throw MappingError.notMappable(message)
        }

        guard let date = Date.dateFromString(_val, withFormat: format) else {
            let message = "The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format."
            throw MappingError.notMappable(message)
        }

        return date
    }

    public func date(forOptional key: String, to format: Date.DateFormat, from json: [String: JSON]?) throws -> Date? {
        guard let _val = json?[key] as? String, !_val.isEmpty else {
            return nil
        }

        guard let date = Date.dateFromString(_val, withFormat: format) else {
            let message = "The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format."
            throw MappingError.notMappable(message)
        }

        return date
    }

}
