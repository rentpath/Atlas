# Atlas
An extremely easy-to-use and lightweight JSON mapping library written in Swift.

Installation
------------

### Carthage
To install this libaray via Cathage, just add the following to your `Cartfile`:
```bash
github "RentPath/Atlas" ~> 1.0
```

### CocoaPods
To install this libaray via CocoaPods, just add the following to your `PodFile`:
```bash
pod 'RPCoreKit', '~> 1.0'
```

### Submodule
To install this library via submodule, just do the following:
```bash
git submodule add git@github.com/rentpath/RPCoreKit
```

### Directly inlcude source
Don't! This is not a good idea since it makes updating dependencies much more difficult and time consuming. Use one of the options above.

How It's Used
-------------

### How It's Used
The Atlas object is used to convert JSON <-> Model as long as the model conforms to the AtlasMap protocol. 

Working with JSON Object - `Dictionary<String: AnyObject>`
---------
```swift
// Here we are converting a user JSON object to a User model instance

// JSON object representing a User
static let userJSON: [String: AnyObject] = [
    "first_name": "John",
    "last_name": "Appleseed",
    "email": "john@test.com",
    "phone": 2223334444,
    "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
    "is_active": true,
    "member_since": "2016-01-30T09:19:52.000"
]

let user: User
do {
    user = try Atlas(userJSON).to(User)!
} catch let error {
    // do something with the error
}
```

Working with JSON Array - `Array<AnyObject>`
---------
```swift
// Here we are converting an array of user JSON objects to an array of User model instances

// JSON array representing a collection of users
static let usersJSON: [AnyObject] = [
    [
        "first_name": "John",
        "last_name": "Appleseed",
        "email": "john@test.com",
        "phone": 2223334444,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": true,
        "member_since": "2016-01-30T09:19:52.000"
    ],
    [
        "first_name": "Jane",
        "last_name": "Appleseed",
        "email": "jane@test.com",
        "phone": 3334445555,
        "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
        "is_active": false,
        "member_since": "2016-01-30T09:19:52.000"
    ]
]

let users: [User]
do {
    users = try Atlas(usersJSON).toArrayOf(User)!
} catch let error {
    // do something with the error
}
```

Here is what the User model could look like
-------

```swift
import Foundation
import Atlas

struct User {
    let firstName: String?
    let lastName: String?
    let email: String
    let phone: Int?
    let avatarURL: String?
    let isActive: Bool
    let memberSince: NSDate?
}

extension User: AtlasMap {
    
    func toJSON() -> [String : AnyObject]? {
        return nil
    }
    
    init?(json: JSON) throws {
        do {
            let map = try Atlas(json)
            firstName = try map.key("first_name").to(String)
            lastName = try map.key("last_name").to(String)
            email = try map.key("email").to(String) ?? ""
            phone = try map.key("phone").to(Int)
            avatarURL = try map.key("avatar").to(String)
            isActive = try map.key("is_active").to(Bool) ?? false
            memberSince = try map.key("member_since").toRFC3339Date()
        } catch let e {
            throw e
        }
    }
    
}
```
###Contributing

Getting Started
---------------
1. Fork this repo
2. Create a new feature branch: `$ git checkout -b my-feature-branch`
3. Build and Test the project to make sure everything is good-to-go
4. Perform your work
5. Add tests and confirm all tests are passing
6. Commit your work: `$ git commit -am 'My awesome work'`
7. Push your work to your feature branch: `$ git push origin my-feature-branch`
8. Create the PR [here](https://github.com/rentpath/Atlas/compare?expand=1)

Tests
------
This library makes heavy use of testing to ensure stable and maintainable code. Please make sure you run the tests often, especially before comitting or creating PR's. To run the tests simply hold in the `command` key and press `u`.

If there are ever failing tests, first stash all of your local changes and run the tests again. This will verify if you made a changed that caused a test failure. There can be two possible outcomes, which are outlined below:

1. There are still failing tests after staging all of your local changes. If this happens, please investigate which commit introduced the failing test(s) and report that to the auther of that commit to address the failing test(s). 

2. All tests pass after you stage all your local changes. This means you've introduced code that caused a failing test(s). Please investigate what test(s) are failing and look at what you changed that caused the test failures. If needed, get with the auther of the test and determine if your changes should be kept and the test should be updated. If not, then you'll need to revert your changes so that the test(s) pass and continue your work with a different implementation that doesn't result in test failures.
