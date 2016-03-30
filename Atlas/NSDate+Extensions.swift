// Copyright 2016 RentPath
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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