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

public enum MappingError: ErrorType {
    
    /**
     
     There is no key available. Please make sure you first call `-key:` and pass the key that corresponds to the value in JSON you want to map.
     
     */
    case NoKeyError
    
    /**
     
     'key' does not exist in `_json`.
     
     - Parameters String: name of key
     
     */
    case KeyNotInJSONError(String)
    
    /**
     
     There was an error during the mapping process
     
     */
    case GenericMappingError
    
    /**
     
     Thrown when `_json` is not of type [String: AnyObject] or [AnyObject], which are the only two types a true JSON object could be
     
     */
    case NotAJSONObjectError
    
    /**
     
     Thrown when not able to map a JSON value to specified type
     
     */
    case NotMappable(String)
    
}
