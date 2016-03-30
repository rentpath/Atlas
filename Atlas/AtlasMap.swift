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