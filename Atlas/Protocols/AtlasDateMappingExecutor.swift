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

public protocol AtlasDateMappingExecutor {
    
    /**
     Map a date string to an instance of NSDate
     
     - Parameters:
        - key: The String to use to pull the value from `object`
        - format: String repesenting the date format to use when parsing the date string
        - object: The Dictonary<String, JSON> used with `key` to pull the value from
     
     - Throws: Will throw a `MappingError` if the `key` doesn't exist within `object`.  Also will throw a `MappingError` if the value of `key` in `object` is not a string type
     
     - Returns: An Optional NSDate
     */
    func dateFromKey(_ key: String, toDateWithFormat format: Date.DateFormat, withinJSONObject object: [String: JSON]?) throws -> Date?
    
    /**
     Optionally map a date string to an instance of NSDate
     
     - Parameters:
        - key: The String to use to pull the value from `object`
        - format: String repesenting the date format to use when parsing the date string
        - object: The Dictonary<String, JSON> used with `key` to pull the value from
     
     - Throws: A `MappingError` will be thrown if the value of `key` in `object` is not a string type
     
     - Returns: An Optional NSDate
     */
    func dateFromOptionalKey(_ key: String, toDateWithFormat format: Date.DateFormat, withinJSONObject object: [String: JSON]?) throws -> Date?
}
