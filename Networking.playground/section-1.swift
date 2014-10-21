// Playground - noun: a place where people can play

import UIKit
import XCPlayground


// this allows playgrounds to run asynch operations
XCPExecutionShouldContinueIndefinitely()

let url = NSURL(string: "http://www.codefellows.org")


// sets up the data task for resource at URL
let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
    if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200...204:
            for header in httpResponse.allHeaderFields {
                println(header)
            }
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString: \(responseString)")
        default:
            println("bad response? \(httpResponse.statusCode)")
        }
    }
})

// this is like starting the task
dataTask.resume()

// this time, we'll download the resource at URL
// allows makes a GET request, uses temporary file behind the scenes

let anotherURL = NSURL(string: "http://www.pdf995.com/samples/pdf.pdf")
let request = NSURLRequest(URL: anotherURL!)
let downloadTask = NSURLSession.sharedSession().downloadTaskWithRequest(request, completionHandler: { (url, response, error) -> Void in
    if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200...204:
            for header in httpResponse.allHeaderFields {
                println(header)
            }
        default:
            println("bad response? \(httpResponse.statusCode)")
        }
    }
})

downloadTask.resume()
