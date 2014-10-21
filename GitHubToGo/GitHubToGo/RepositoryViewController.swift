//
//  RepositoryViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/20/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIApplicationDelegate {
    
    var networkController : NetworkController!
    
    var repositories : [Repository]?
    
    @IBOutlet weak var repositoryTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.repositoryTableView.delegate = self
        self.repositoryTableView.dataSource = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController

        self.networkController.fetchRepositoriesUsingSearch("Some Word", completionHandler: { (errorDescription, repos) -> (Void) in
            if errorDescription != nil {
                println("\(errorDescription)")
            } else {
                self.repositories = repos
                self.repositoryTableView.reloadData()
            }
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repositories != nil {
            return self.repositories.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = repositoryTableView.dequeueReusableCellWithIdentifier("SHOW_REPO", forIndexPath: indexPath) as RepoCell
        let singleRepo = repositories?[indexPath.row]
        
        // use some part of repo info to populate the cell
        
        cell.repoLabel?.text = singleRepo?.loginName
        
        return cell
        
    }
    

}
