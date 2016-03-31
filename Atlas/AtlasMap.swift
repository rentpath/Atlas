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


/// A simple typealias used to make the initializer of RPJSONMappable more descriptive as to the type of object passed in. That is, it is a JSON response which can be either a Dictionary<String, AnyObject> or Array<AnyObject>.
public typealias JSON = AnyObject

public protocol AtlasMap {
    /**
     u
     converts model to JSON
     
     - Returns: Dictionary with String key and AnyObject Value
     
     */
    func toJSON() -> [String: AnyObject]?
    
    /**
     
     Convert JSON to Model
     
     - Parameters json: JSON string which can be either a Dictionary<String, AnyObject> or Array<AnyObject>.
     
     - Throws: Error that is type of MappingError
     
     */
    init?(json: JSON) throws
}