//
//  NetworkController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/20/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import Foundation
import UIKit

class NetworkController {
    
    let clientID = "client_id=1a40ab045973dd97766d"
    let clientSecret = "client_secret=10d0732ff5a596b1d31dac0338af2b440e2d787c"
    let gitHubOAuthURL = "https://github.com/login/oauth/authorize?"
    let scope = "scope=user,repo"
    let redirectURL = "redirect_uri=somefancyname://test"
    let githubPostURL = "https://github.com/login/oauth/access_token"
    
    
   
    func fetchRepositoriesUsingSearch(completionHandler : (errorDescription : String?, repos: [Repository]?) -> (Void)) {
        
        let url = NSURL(string: "http://127.0.0.1:3000")
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        let repos = Repository.parseJSONIntoRepositories(data)
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            completionHandler(errorDescription: nil, repos: repos)
                        })
                    default:
                        completionHandler(errorDescription: "Something went wrong. Status code: \(httpResponse.statusCode)", repos: nil)
                    }
                }
            } else {
                println("error: \(error.description)")
            }
        })
        
        dataTask.resume()
        
    }
    
    
    func requestOAuthAccess() {
        let url = gitHubOAuthURL + clientID + "&" + redirectURL + "&" + scope
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func handleOAuthURL(callbackURL : NSURL) {
        let query = callbackURL.query
        let components = query?.componentsSeparatedByString("code=")
        let code = components?.last
        
        let urlQuery = clientID + "&" + clientSecret + "&" + "code=\(code!)"
        var request = NSMutableURLRequest(URL: NSURL(string: githubPostURL)!)
        request.HTTPMethod = "POST"
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        
        let dataTask: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println(error.description)
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        println(tokenResponse)
                        
                        var configuration = NSURLSessionConfiguration()
                        configuration.setValue("token OAUTH-TOKEN", forKey: "Authorization")
                        var mySession = NSURLSession(configuration: configuration)
                    default:
                        println("default case on status code")
                    }
                }
            }
        }).resume()
    }

}
