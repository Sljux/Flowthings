
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

Alamofire.request(.POST, "http://httpbin.org/post", parameters: parameters)
// HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
```

### Parameter Encoding

Parameters can also be encoded as JSON, Property List, or any custom format, using the `ParameterEncoding` enum:

```swift
enum ParameterEncoding {
    case URL
    case JSON
    case PropertyList(format: NSPropertyListFormat, options: NSPropertyListWriteOptions)
    case Custom((URLRequestConvertible, [String: AnyObject]?) -> (NSMutableURLRequest, NSError?))

    func encode(request: NSURLRequest, parameters: [String: AnyObject]?) -> (NSURLRequest, NSError?)
    { ... }
}
```

- `URL`: A query string to be set as or appended to any existing URL query for `GET`, `HEAD`, and `DELETE` requests, or set as the body for requests with any other HTTP method. The `Content-Type` HTTP header field of an encoded request with HTTP body is set to `application/x-www-form-urlencoded`. _Since there is no published specification for how to encode collection types, Alamofire follows the convention of appending `[]` to the key for array values (`foo[]=1&foo[]=2`), and appending the key surrounded by square brackets for nested dictionary values (`foo[bar]=baz`)._
- `JSON`: Uses `NSJSONSerialization` to create a JSON representation of the parameters object, which is set as the body of the request. The `Content-Type` HTTP header field of an encoded request is set to `application/json`.
- `PropertyList`: Uses `NSPropertyListSerialization` to create a plist representation of the parameters object, according to the associated format and write options values, which is set as the body of the request. The `Content-Type` HTTP header field of an encoded request is set to `application/x-plist`.
- `Custom`: Uses the associated closure value to construct a new request given an existing request and parameters.

#### Manual Parameter Encoding of an NSURLRequest

```swift
let URL = NSURL(string: "http://httpbin.org/get")!
var request = NSURLRequest(URL: URL)

let parameters = ["foo": "bar"]
let encoding = Alamofire.ParameterEncoding.URL
(request, _) = encoding.encode(request, parameters: parameters)
```

#### POST Request with JSON-encoded Parameters

```swift
let parameters = [
    "foo": [1,2,3],
    "bar": [
        "baz": "qux"
    ]
]

Alamofire.request(.POST, "http://httpbin.org/post", parameters: parameters, encoding: .JSON)
// HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}
```

### HTTP Headers

Adding a custom HTTP header to a `Request` is supported directly in the global `request` method. This makes it easy to attach HTTP headers to a `Request` that can be constantly changing.

> For HTTP headers that do not change, it is recommended to set them on the `NSURLSessionConfiguration` so they are automatically applied to any `NSURLSessionTask` created by the underlying `NSURLSession`.

```swift
let headers = [
    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
    "Content-Type": "application/x-www-form-urlencoded"
]

Alamofire.request(.GET, "http://httpbin.org/get", headers: headers)
         .responseJSON { _, _, result in
             debugPrint(result)
         }
```

### Caching

Caching is handled on the system framework level by [`NSURLCache`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSURLCache_Class/Reference/Reference.html#//apple_ref/occ/cl/NSURLCache).

### Uploading

**Supported Upload Types**

- File
- Data
- Stream
- MultipartFormData

#### Uploading a File

```swift
let fileURL = NSBundle.mainBundle().URLForResource("Default", withExtension: "png")
Alamofire.upload(.POST, "http://httpbin.org/post", file: fileURL)
```

#### Uploading with Progress

```swift
Alamofire.upload(.POST, "http://httpbin.org/post", file: fileURL)
         .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
             print(totalBytesWritten)
         }
         .responseJSON { request, response, result in
             debugPrint(result)
         }
```

#### Uploading MultipartFormData

```swift
Alamofire.upload(
    .POST,
    URLString: "http://httpbin.org/post",
    multipartFormData: { multipartFormData in
        multipartFormData.appendBodyPart(fileURL: unicornImageURL, name: "unicorn")
        multipartFormData.appendBodyPart(fileURL: rainbowImageURL, name: "rainbow")
    },
    encodingCompletion: { encodingResult in
    	switch encodingResult {
    	case .Success(let upload, _, _):
            upload.responseJSON { request, response, result in
                debugPrint(result)
            }
    	case .Failure(let encodingError):
    	    print(encodingError)
    	}
    }
)
```
