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

public extension NSDate {
    
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
     
     Convert RFC3339 date string to NSDate
     
     - Parameters string: RFC3339 date string
     
     - Returns: An Optional NSDate
     
     */
    public class func dateFromRFC3339String(string: String) -> NSDate? {
        return dateFromString(string, withFormat: "yyyy-MM-dd'T'HH:mm:ss.S'Z'")
    }
    
    /**
     
     NSDate extention to convert NSDate to "pretty" date string (eg: "Fri Feb 05, 2016 at 9:41 am").
     
     - Returns: String date with pretty format
     
     */
    public func toPrettyString() -> String {
        let formatter = Static.formatter
        formatter.dateFormat = "E MMM dd, yyyy 'at' h:mm a"
        return formatter.stringFromDate(self)
    }
    
    /**
     
     NSDate extention to convert NSDate to "short pretty" date string (eg: "02/05/2016")
     
     - Returns: String date with short pretty format
     
     */
    public func toShortPrettyString() -> String {
        let formatter = Static.formatter
        formatter.dateFormat = "MM/dd/yy"
        return formatter.stringFromDate(self)
    }
    
    /**
     
     Convert date string to date for a given format
     
     - Parameters:
        - dateString: string date
        - withFormat: format of the string date
     
     - Returns: NSDate after converting dateString
     
     */
    public class func dateFromString(dateString: String, withFormat format: String) -> NSDate? {
        let formatter = Static.formatter
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)
    }
    
    /**
     
    NSDate extention to get beginning of day. Midnight of given date (eg: 02/05/2015 00:00:00)
    
     - Returns: NSDate 
     
     */
    public func beginningOfDay() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
    /**
     
     NSDate extention to get end of day. One second before Midnight of given date (eg: 02/05/2015 23:59:59)
     
     - Returns: NSDate
     
     */
    public func endOfDay() -> NSDate {
        let components = NSDateComponents()
        components.day = 1
        var date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.beginningOfDay(), options: [])!
        date = date.dateByAddingTimeInterval(-1)
        return date
    }
    
}