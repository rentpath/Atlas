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

extension AtlasMappingExecutor: AtlasDateMappingExecutor {
    
    public var dateMappingExecutor: AtlasDateMappingExecutor? {
        get {
            return self
        }
    }
    
    public func dateFromKey(key: String, toDateWithFormat format: NSDate.DateFormat, withinJSONObject object: [String: JSON]?) throws -> NSDate? {
        guard let _val = object?[key] as? String where !_val.isEmpty else {
            throw MappingError.NotMappable("The value of key \(key) in the provided JSON object isn't a String and therefore cannot be mapped to an NSDate.")
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: format) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format.")
        }
        
        return date
    }
    
    public func dateFromOptionalKey(key: String, toDateWithFormat format: NSDate.DateFormat, withinJSONObject object: [String: JSON]?) throws -> NSDate? {
        guard let _val = object?[key] as? String where !_val.isEmpty else {
            return nil
        }
        
        guard let date = NSDate.dateFromString(_val, withFormat: format) else {
            throw MappingError.NotMappable("The date string \(_val) of key \(key) in the provided JSON object does not match the RFC3339 format.")
        }
        
        return date
    }
    
}
