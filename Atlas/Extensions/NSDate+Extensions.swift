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

public extension NSDate {
    
    public enum DateFormat {
        case RFC3339, ISO8601, Custom(String)
    }
    
    private struct Static {
        static var formatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
            return formatter
        }()
    }
    
    /**
     
     NSDate extention to convert NSDate to RFC3339 standard (eg: "2016-02-05T12:30:05.123Z").
     
     - returns String date with RFC3339 format
     
     */
    public func toRFC3339String() -> String {
        let formatter = Static.formatter
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
        return formatter.stringFromDate(self)
    }
    
    /**
     
     NSDate extention to convert NSDate to RFC3339 standard (eg: "2016-02-05T12:30:05.123Z").
     
     - returns String date with RFC3339 format
     
     */
    public func toISO8601String() -> String {
        let formatter = Static.formatter
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
        return formatter.stringFromDate(self)
    }
    
    /**
     
     Convert RFC3339 date string to NSDate
     
     - Parameter string: RFC3339 date string
     
     - Returns: An Optional NSDate
     
     */
    public class func dateFromRFC3339String(string: String) -> NSDate? {
        return dateFromString(string, withFormat: .RFC3339)
    }
    
    /**
     
     Convert date string to date for a given format
     
     - Parameters:
        - dateString: string date
        - withFormat: format of the string date
     
     - Returns: NSDate after converting dateString
     
     */
    public class func dateFromString(dateString: String, withFormat format: DateFormat) -> NSDate? {
        let formatter = Static.formatter
        switch format {
        case .RFC3339:
            fallthrough
        case .ISO8601:
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
        case let .Custom(_format):
            formatter.dateFormat = _format
        }
        
        return formatter.dateFromString(dateString)
    }
    
}