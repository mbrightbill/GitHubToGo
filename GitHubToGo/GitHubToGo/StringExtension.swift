//
//  StringExtension.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/25/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import Foundation

extension String {
    func validate() -> Bool {
        var error: NSError?
        
        let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: &error)
        let match = regex?.numberOfMatchesInString(self, options: nil, range: NSRange(location: 0, length: countElements(self)))
        if match > 0 {
            return false
        }
        return true
    }
}
