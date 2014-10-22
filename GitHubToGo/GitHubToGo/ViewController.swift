//
//  ViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/21/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var networkController : NetworkController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController

        self.networkController.requestOAuthAccess()
    }


}
