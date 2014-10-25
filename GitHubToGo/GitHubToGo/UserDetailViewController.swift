//
//  UserDetailViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/25/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user: User?
    var networkController: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        self.networkController?.convertURLStringToUsableImage(user!, completionHandler: { (usableImage) -> (Void) in
            self.imageView.image = usableImage
        })
        
        self.userNameLabel.text = self.user?.userName
        
    }
}
