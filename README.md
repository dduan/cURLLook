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
