
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Flowthings is an flowthings.io library written in Swift.

## Requirements v0.3.7

- iOS 8.0+ / Mac OS X 10.9+ / watchOS 2
- Xcode 7.0+

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

Note: This will move to [flowthings repository](https://github.com/flowthings) once officially released, (when Xcode 7 is out of the beta)


### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate Flowthings into your project manually.

## Usage

### Making a Request

You will need your flowthings.io account:

then from this link https://dev.flowthings.io/#/account get:

- [accountID](https://dev.flowthings.io/#/account) - your username
- [tokenID](https://dev.flowthings.io/#/account) - your token

![image](https://www.evernote.com/l/AAqDH6Fg-yxIGKe_72iOkZNV--_6fxqs8ikB/image.png)

#### Steps to set it up  (e.g. create drop)

Step 1.

Add import to top of your file 
```swift
import Flowthings
```

Step 2.

Setup Creds.
```swift
  let api = FTAPI(
      accountID: "XXX",
      tokenID: "XXX"
  )
```
Step 3.
Set path to send data to and prepare data to send
```swift
  let params : [String:AnyObject] = [
      "path" : "/<your-account-id>/framework/unit-test",
      "elems":[
          "task":"running test",
          "description": "UnitTest testDropCreateOnPath"
      ]
  ]
```
Step 4.
Make a call, and response in success and failure closures 
```swift
  api.drop.create(params: params)
      .success {
          json in
          print(json["body"]["id"].string)
      }
      .failure {
          error in
          print(error)
  	  }
```

That is all you need to get you going.

#### Alternative way to set Creds
You can also set creds in **Config.plist** inside of your app

![Setting Flowthings creds in Config.plist](https://www.evernote.com/l/AAoDCAMPFy1C8ZfSa_RRiKPLgSYQz0YoXOwB/image.png)

#### Alternative FTStream chaining response (promise.then() style also optional progress included for monitoring of big requests)
```swift
  api.drop.create(params: params)
  	.progress {
                (oldProgress: Progress?, newProgress: Progress) in
                print("IN.PROGRESS")
                print("\(newProgress.bytesWritten)")
                print("\(newProgress.totalBytesWritten)")
                print("\(newProgress.totalBytesExpectedToWrite)")
                
            }
	.then{
           value, error -> Value in
           print("IN.FIRST.THEN")
           if let _ = error {
	           return nil
           }
	       print("Value:", value?.type)
	       return value!
       }
	.then{
           value, error -> Value in
           print("IN.SECOND.THEN")
           ...
       }
	.then{
           value, error -> Void in
           print("IN.THIRD.THEN")
           ...
	}
```
Note: Success in this one is called only if there was no error to start with

#### Networking is done _asynchronously
> Networking is done _asynchronously_. Asynchronous programming may be a source of frustration to programmers unfamiliar with the concept, but there are [very good reasons](https://developer.apple.com/library/ios/qa/qa1693/_index.html) for doing it this way.

> Rather than blocking execution to wait for a response from the server, a [callback](http://en.wikipedia.org/wiki/Callback_%28computer_programming%29) is specified to handle the response once it's received. The result of a request is only available inside the scope of a response handler. Any execution contingent on the response or data received from the server must be done within a handler.

####  Checking Response JSON

```swift
guard let id = json["test"]["id"].string else {
  ...
}
```

#### HTTP Methods

`Flowthings.FTMethod` lists the HTTP methods defined in [RFC 7231 Â§4.3](http://tools.ietf.org/html/rfc7231#section-4.3):

```swift
public enum FTMethod : String {
    case GET, POST, PUT, DELETE
    //Headers not needed/supported
    //case OPTIONS, HEAD, PATCH, TRACE, CONNECT
}
```

### Parameters
All requests requardless of their METHOD type support  ```swift [String:AnyObject] ```


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
