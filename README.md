This μ-framework serializes your `NSURLRequest` object to
a [cURL](http://curl.haxx.se) command, so you can convey to a backend person
clearly what kind of HTTP request your code is making.

```swift
let request: NSURLRequest
let aSession: NSURLSession

// … after you created your URL session and request, this will give you
// a cURL command that also performs this request
print(request.cURLRepresentation(withURLSession: aSession))


// alternatively, you can use this convenient proprety without a session:
print(request.cURLString)

```

# Install

## Carthage (recommended)

Include the following in your Cartfile:

    github "dduan/cURLLook"

## Cocoapods

The usual way:

    platform :ios, '8.0'
    use_frameworks!

    target 'MyApp' do
      pod 'cURLLook'
    end

# Credit

The code is an adaption from
[Alamofile](https://github.com/Alamofire/Alamofire)
