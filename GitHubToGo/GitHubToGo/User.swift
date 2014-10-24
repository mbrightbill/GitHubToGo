//
//  User.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/23/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var userName : String
    var avatarURL : String
    var userImage : UIImage?
    
    init(initialDictionary : NSDictionary) {
        self.userName = initialDictionary["login"] as String
        self.avatarURL = initialDictionary["avatar_url"] as String
    }
    
    
    class func parseJSONIntoUsers(rawJSONData : NSData) -> [User]? {
        var error: NSError?
        
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            var users = [User]()
            
            if let itemsJSONArray = JSONDictionary["items"] as? NSArray {
                for object in itemsJSONArray {
                    if let userKeyValues = object as? NSDictionary {
                        let user = User(initialDictionary: userKeyValues)
                        users.append(user)
                    }
                }
            }
            return users
        }
        return nil
        
    }
    
}
