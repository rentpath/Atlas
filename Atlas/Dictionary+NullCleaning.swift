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

extension Dictionary {
    
    /**
     
     Dictionary extention method to remove null values
     
     - Returns: Dictionary with null values removed
     
     */
    func cleaned() -> Dictionary {
        var cleanedDict = [Key: Value]()
        let o = filter({ $0.1 != nil && !($0.1 is NSNull) })
        for val in o {
            switch val.1 {
            case let _val as [String: AnyObject]:
                cleanedDict[val.0] = _val.cleaned() as? Value
            default:
                cleanedDict[val.0] = val.1
            }
        }
        
        return cleanedDict
    }
    
}
