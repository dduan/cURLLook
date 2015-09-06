//
//  NSURLRequestCURLRepresentation.swift
//  cURLLook
//
//  Created by Daniel Duan on 9/5/15.
//
//

import Foundation

extension NSURLRequest {
    /**
        Convenience property, the value of calling `cURLRepresentation()` with no arguments.
    */
    var cURLString: String {
        get {
            return cURLRepresentation()
        }
    }

    /**
    cURL (http://http://curl.haxx.se) is a commandline tool that makes network requests. This method serializes a `NSURLRequest` to a cURL
    command that performs the same HTTP request.

    - Parameter session:    *optional* the `NSURLSession` this NSURLRequest is being used with. Extra information from the session such as
                            cookies and credentials may be included in the result.
    - Parameter credential: *optional* the credential to include in the result. The value of `session?.configuration.URLCredentialStorage`,
                            when present, would override this argument.

    - Returns:              a string whose value is a cURL command that would perform the same HTTP request this object represents.
    */
    func cURLRepresentation(withURLSession session: NSURLSession? = nil, credential: NSURLCredential? = nil) -> String {
        var components = ["curl -i"]

        let URL = self.URL

        if let HTTPMethod = self.HTTPMethod where HTTPMethod != "GET" {
            components.append("-X \(HTTPMethod)")
        }

        if let credentialStorage = session?.configuration.URLCredentialStorage {
            let protectionSpace = NSURLProtectionSpace(
                host: URL!.host!,
                port: URL!.port?.integerValue ?? 0,
                `protocol`: URL!.scheme,
                realm: URL!.host!,
                authenticationMethod: NSURLAuthenticationMethodHTTPBasic
            )

            if let credentials = credentialStorage.credentialsForProtectionSpace(protectionSpace)?.values {
                for credential in credentials {
                    components.append("-u \(credential.user!):\(credential.password!)")
                }
            } else {
                if credential != nil {
                    components.append("-u \(credential!.user!):\(credential!.password!)")
                }
            }
        }

        if session != nil && session!.configuration.HTTPShouldSetCookies {
            if let
                cookieStorage = session!.configuration.HTTPCookieStorage,
                cookies = cookieStorage.cookiesForURL(URL!) where !cookies.isEmpty
            {
                let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value ?? String());" }
                components.append("-b \"\(string.substringToIndex(string.endIndex.predecessor()))\"")
            }
        }

        if let headerFields = self.allHTTPHeaderFields {
            for (field, value) in headerFields {
                switch field {
                case "Cookie":
                    continue
                default:
                    components.append("-H \"\(field): \(value)\"")
                }
            }
        }

        if let additionalHeaders = session?.configuration.HTTPAdditionalHeaders {
            for (field, value) in additionalHeaders {
                switch field {
                case "Cookie":
                    continue
                default:
                    components.append("-H \"\(field): \(value)\"")
                }
            }
        }

        if let
            HTTPBodyData = self.HTTPBody,
            HTTPBody = NSString(data: HTTPBodyData, encoding: NSUTF8StringEncoding)
        {
            let escapedBody = HTTPBody.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
            components.append("-d \"\(escapedBody)\"")
        }

        components.append("\"\(URL!.absoluteString)\"")
        
        return components.joinWithSeparator(" \\\n\t")
    }
    
}
