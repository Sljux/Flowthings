
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Flowthings is an flowthings.io library written in Swift.

## Requirements

- iOS 8.0+ / Mac OS X 10.9+ / watchOS 2
- Xcode 7.0 beta 5+

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).**

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Flowthings into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "appsmonkey/Flowthings"
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate Flowthings into your project manually.

## Usage

### Making a Request

[flowthings.io token and account id] (https://dev.flowthings.io/#/account)
```swift
import Flowthings

  let api = FlowthingsAPI(
      accountID: "XXX",
      tokenID: "XXX"
  )
        
  let params : [String:AnyObject] = [
      "path" : "/ceco/framework/test1",
      "elems":[
          "task":"running test",
          "description": "UnitTest testDropCreateOnPath"
      ]
  ]
        
  api.drop.create(
      params: params,
      success:{
          json in
          guard let id = json["test"]["id"].string else {
            print("Missing id")
            return
          }
          print(id)
      },
      failure:{
          error in
          print(error)
  })
```

> Networking is done _asynchronously_. Asynchronous programming may be a source of frustration to programmers unfamiliar with the concept, but there are [very good reasons](https://developer.apple.com/library/ios/qa/qa1693/_index.html) for doing it this way.

> Rather than blocking execution to wait for a response from the server, a [callback](http://en.wikipedia.org/wiki/Callback_%28computer_programming%29) is specified to handle the response once it's received. The result of a request is only available inside the scope of a response handler. Any execution contingent on the response or data received from the server must be done within a handler.

####  Response JSON Handler

```swift
guard let id = json["test"]["id"].string else {
  ...
}
```


### HTTP Methods

`Flowthings.Method` lists the HTTP methods defined in [RFC 7231 §4.3](http://tools.ietf.org/html/rfc7231#section-4.3):

```swift
public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}
```

### Parameters


#### POST & GET Request 



```swift
let parameters = [
    "foo": "bar",
    "baz": ["a", 1],
    "qux": [
        "x": 1,
        "y": 2,
        "z": 3
    ]
]

```
## Extensions

example of extending service

```swift
extension Drop {
    
    public func createOnFlowID(
        flowID flowID: String,
        params: [String:AnyObject],
        success: (json: JSON)->(),
        failure: (error: FTAPIError)->())  {
            
            let path = baseURL + flowID
            
            FTAPI.request(.POST, path: path, parameters: params,
                success: {
                    json in
                    
                    //Verify that ID came back
                    guard let _ = json!["body"]["id"].string else {
                        failure(error: .UnexpectedJSONFormat(json))
                        return
                    }
                    
                    success(json: json!)
                },
                failure: {
                    error in
                    failure(error: error)
            })
    }
}
```
