// Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

let url = NSURL(string: "http://www.codefellows.org")

let data = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
    
    if let httpReponse = response as? NSHTTPURLResponse {
        swith httpResponse.statusCode {
            case 200...204:
        }
    }
    
    
})

dataTask.resume()