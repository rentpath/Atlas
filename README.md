![Atlas](https://raw.githubusercontent.com/rentpath/Atlas/master/rentpath_atlas.jpg?token=AA-NdfXBVDgrelm18bcO75eMF7SqVbeYks5XBpK_wA%3D%3D)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Atlas
An extremely easy-to-use and lightweight JSON mapping library for iOS and tvOS written in Swift

# Installation

### Carthage
To install this library via Carthage, just add the following to your `Cartfile`:
```bash
github "rentpath/Atlas" ~> 1.0
```

### Submodule
To install this library via submodule, just do the following:
```bash
git submodule add git@github.com/rentpath/Atlas
```

### Directly include source
**Don't!** This is not a good idea since it makes updating dependencies much more difficult and time consuming. Use one of the options above.

# How It's Used

Atlas is used to convert JSON <-> Model as long as the model conforms to the `AtlasMap` protocol.

### Working with a JSON Object

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

### Working with a JSON Array

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

### Here is what the User model could look like

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

# Error handling

We wanted to make the errors returned by Atalas descriptive and clearly explain why something failed. Here's a simple example of how valuable the errors can be to debugging a JSON mapping issue.

Say you have a JSON object like this one you are fetching from a remote server:

```swift
{
    "first_name": "John",
    "last_name": "Appleseed",
    "email": "john@test.com",
    "phone": 2223334444,
    "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
    "is_active": true,
    "member_since": "2016-01-30T09:19:52.000"
}
```

You've implemented Atlas and all of your JSON mapping is working great. Then one day things stop working and the JSON mapping is failing due to a server side change in the JSON object being sent back. For the sake of this example, here's what you determine the new JSON object looks like after the server side changes:

```swift
{
    "first_name": "John",
    "last_name": "Appleseed",
    "email": "john@test.com",
    "phone": "2223334444",
    "avatar": "https://www.somedomain.com/users/images/asdfa43weefew4ee.jpg",
    "is_active": true,
    "member_since": "2016-01-30T09:19:52.000"
}
```

Notice the `phone` number is now a `String` and no longer an `Int`. In this example, Atlas would be throwing a `MappingError.NotMappable` error with the message ".phone - Unable to map 2223334444 to type Int".

Let's say the `phone` KVP was removed from the JSON object alltogether, Atlas would throw a `MappingError.KeyNotInJSONError` with the message "Mapping to Int failed. phone is not in the JSON object provided.".

See [MappingError.swift](https://github.com/rentpath/Atlas/blob/master/Atlas/MappingError.swift) for all of the possible errors that Atlas can throw.

# Contributing

### Workflow

1. Fork this repo
2. Create a new feature branch: `$ git checkout -b my-feature-branch`
3. Build and Test the project to make sure everything is good-to-go
4. Perform your work
5. Add tests and confirm all tests are passing
6. Commit your work: `$ git commit -am 'My awesome work'`
7. Push your work to your feature branch: `$ git push origin my-feature-branch`
8. Create the PR [here](https://github.com/rentpath/Atlas/compare?expand=1)

### Tests

This library makes heavy use of testing to ensure stable and maintainable code. Please make sure you run the tests often, especially before committing or creating PR's. To run the tests simply hold in the `command` key and press `u`.

If there are ever failing tests, first stash all of your local changes and run the tests again. This will verify if you made a changed that caused a test failure. There can be two possible outcomes, which are outlined below:

1. There are still failing tests after staging all of your local changes. If this happens, please investigate which commit introduced the failing test(s) and report that to the auther of that commit to address the failing test(s).

2. All tests pass after you stage all your local changes. This means you've introduced code that caused a failing test(s). Please investigate what test(s) are failing and look at what you changed that caused the test failures. If needed, get with the auther of the test and determine if your changes should be kept and the test should be updated. If not, then you'll need to revert your changes so that the test(s) pass and continue your work with a different implementation that doesn't result in test failures.

# License

Atlas is released under the MIT License. See the bundled LICENSE file for details.
