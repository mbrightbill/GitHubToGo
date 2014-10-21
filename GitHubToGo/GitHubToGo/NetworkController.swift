//
//  NetworkController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/20/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import Foundation

class NetworkController {
   
    func fetchRepositoriesUsingSearch(keyWord : String, completionHandler : (errorDescription : String?, repos: [Repository]?) -> (Void)) {
        
        let url = NSURL(string: "http//localhost:3000")
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    let repos = Repository.parseJSONIntoRepositories(data)
                    completionHandler(errorDescription: nil, repos: repos)
                default:
                    completionHandler(errorDescription: "Something went wrong. Status code: \(httpResponse.statusCode)", repos: nil)
                }
            }
        })
        
        dataTask.resume()
        
    }
    

}
