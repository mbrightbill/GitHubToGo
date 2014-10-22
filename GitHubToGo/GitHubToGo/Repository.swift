//
//  Repository.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/20/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class Repository {
    
    var name : String
    var fullName : String
    var owner : NSDictionary
    var apiUrl : String
    var description : String
    var loginName : String
    var avatarUrl : String
    
    init(attributeDictionary : NSDictionary) {
        self.name = attributeDictionary["name"] as String
        self.fullName = attributeDictionary["full_name"] as String
        self.owner = attributeDictionary["owner"] as NSDictionary
        self.apiUrl = owner["url"] as String
        self.description = attributeDictionary["description"] as String
        self.loginName = owner["login"] as String
        self.avatarUrl = owner["avatar_url"] as String
    }
    
    
    class func parseJSONIntoRepositories(rawJSONData : NSData) -> [Repository]? {
        var error: NSError?
        
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            var repositories = [Repository]()
            
            if let itemsJSONArray = JSONDictionary["items"] as? NSArray {
                for object in itemsJSONArray {
                    if let repoInfo = object as? NSDictionary {
                        let repo = Repository(attributeDictionary: repoInfo)
                        repositories.append(repo)
                    }
                    
                }
                
            }
            return repositories
            
        }
        return nil
    }

}


