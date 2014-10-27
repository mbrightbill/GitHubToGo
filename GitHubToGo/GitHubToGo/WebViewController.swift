//
//  WebViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/25/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    var repo: Repository?

    override func loadView() {
        self.view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repoName = self.repo?.name
        let loginName = self.repo?.loginName
        println(loginName)
        println(repoName)
        if self.repo != nil {
            var url = NSURL(string: "https://github.com/\(loginName!)/\(repoName!)")
            self.webView.loadRequest(NSURLRequest(URL: url!))
            println(url!)
        }
    }
}
