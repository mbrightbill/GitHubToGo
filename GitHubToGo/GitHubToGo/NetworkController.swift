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
    let redirectURL = "redirect_uri=githubtogoapp://www.github.com"
    let githubPostURL = "https://github.com/login/oauth/access_token"
    let apiURL = "https://api.github.com"
    
    var authenticationConfig: NSURLSessionConfiguration?
    var finalToken : String?
    var session : NSURLSession?
    let oAuthTokenKey : String?
    
    init() {
        
        self.authenticationConfig = nil
        
        self.oAuthTokenKey = "OAuthTokenKey"
        if let token = NSUserDefaults.standardUserDefaults().objectForKey(oAuthTokenKey!) as? NSString {
            self.setupConfigWithAccessToken(token)
        }
        
    }
    
    
   
    func fetchRepositoriesUsingSearch(inputString: String, completionHandler : (repos: [Repository]?) -> (Void)) {
        
        let searchString = inputString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let searchURLString = self.apiURL + "/search/repositories?q=" + searchString
        let searchURLFinal = NSURL(string: searchURLString)
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(searchURLFinal!, completionHandler: { (data, response, error) -> Void in
            var error: NSError?
            
            if error == nil {
                let repos = Repository.parseJSONIntoRepositories(data)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionHandler(repos: repos)
                })
            } else {
                println("There's an error here.")
            }
        })
        
        dataTask.resume()
        
    }
    
    
    func requestOAuthAccess() {
        let url = self.gitHubOAuthURL + self.clientID + "&" + self.redirectURL + "&" + self.scope
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func handleOAuthURL(callbackURL : NSURL) {
        let query = callbackURL.query // gives anything after question mark
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
        
        var dataTask: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println(error.description)
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        self.helperToGrabToken(tokenResponse!)
                        self.setupConfigWithAccessToken(self.finalToken!)
                        self.session = NSURLSession(configuration: self.authenticationConfig!)
                        
                    default:
                        println("default case on status code")
                    }
                }
            }
            NSUserDefaults.standardUserDefaults().setObject(self.finalToken, forKey: self.oAuthTokenKey!)
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }).resume()
    }
    
    
    func isAuthenticated() -> Bool {
        
        let oAuthTokenKey = "OAuthTokenKey"
        if let token = NSUserDefaults.standardUserDefaults().objectForKey(oAuthTokenKey) as? NSString {
            return true
        }
        return false
        
    }

    func setupConfigWithAccessToken(token: String) -> Void {
        
        self.authenticationConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.authenticationConfig?.HTTPAdditionalHeaders = ["Authorization" : "token \(token)"]
    }
    
    func helperToGrabToken(string: String) -> String? {
        
        let firstTokenScreen = string.componentsSeparatedByString("&")
        for keyValueItem in firstTokenScreen {
            let potentialTokenValue = keyValueItem.componentsSeparatedByString("=")
            if let key = potentialTokenValue.first {
                if key == "access_token" {
                    self.finalToken = potentialTokenValue.last
                    return finalToken
                }
            }
        }
        return nil

    }
    
    
}
