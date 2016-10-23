# JSContextFoundation
JSContextFoundation is a Swift adapter for the JavaScriptCore Framework to build up the JavaScript runtime environment.

[![GitHub release](https://img.shields.io/github/release/kf99916/JSContextFoundation.svg)](https://github.com/kf99916/JSContextFoundation)
[![CocoaPods](https://img.shields.io/cocoapods/v/JSContextFoundation.svg)](#cocoapods)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/github/license/kf99916/JSContextFoundation.svg)](LICENSE)

## Requirements

- iOS 8.0 or higher
- Swift 2.3

## Installation

- [CocoaPods](http://cocoapods.org/):

Swift 2.3
```ruby
pod 'JSContextFoundation', '~> 0.0.1'
```

Swift 3
```ruby
pod 'JSContextFoundation', '~> 0.1'
```

- [Swift Package Manager](https://swift.org/package-manager/):

Swift 2.3
```
.Package(url: "https://github.com/kf99916/JSContextFoundation.git", majorVersion: 0.0.1)
```

Swift 3
```
.Package(url: "https://github.com/kf99916/JSContextFoundation.git", majorVersion: 0.1)
```

## JavaScript Runtime Environment
JSContextFoundation builds up the global objects for the JavaScript runtime environment to allow you execute JavaScript code like as in browser or Node.js. Here is the support list for the global objects:

```javascript
global;
window;
console
  .log([data][, ...]);
  .info([data][, ...]);
  .warn([data][, ...]);
  .error([data][, ...]);
```

## Usage

```swift
import JSContextFoundation

let jsContext = JSContextFoundation()
```

### Import JavaScript Module
To import JavaScript module, the source of module can be file path or URL: 
#### File Path

```swift
let path = NSBundle(forClass: self.dynamicType).pathForResource("Module", ofType: "js")!
do {
  try jsContext.requireWithPath(path)
} catch JSContextFoundationError.FileNotFound {
  print(path + " is not found")
} catch JSContextFoundationError.FileNotLoaded {
  print(path + " cannot be loaded")
} catch {
  print("Unknow Exception")
}

// ...
```

#### URL

```swift
let url = NSURL(string: "https://FQDN/Module.js")!
jsContext.requireWithUrl(url, completionHandler: {error in
   if let error = error {
      switch error {
        case JSContextFoundationError.FileNotFound:
            print(url.absoluteString + " is not found")
        case JSContextFoundationError.FileNotDownloaded:
            print(url.absoluteString + " is not downloaded")
        default:
            print("Unknown Error")
        }
        
        return
    }

    //  ...
})
```

All other usage is the same as JSContext. See [JSContext in the Apple document](https://developer.apple.com/library/ios/documentation/JavaScriptCore/Reference/JSContext_Ref/index.html) for details.

## Author

Zheng-Xiang Ke, kf99916@gmail.com

## License
JSContextFoundation is available under the MIT license. See the LICENSE file for more info.

