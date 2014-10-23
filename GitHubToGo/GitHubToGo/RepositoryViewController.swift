//
//  RepositoryViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/20/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController,UITableViewDataSource, UIApplicationDelegate, UISearchBarDelegate {
    
    var networkController : NetworkController!
    
    var repositories : [Repository]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var repositoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.repositoryTableView.dataSource = self
        self.searchBar.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        self.searchBar.placeholder = "Search Repositories"
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.networkController.fetchRepositoriesUsingSearch(searchBar.text, completionHandler: { (repos) -> (Void) in
            self.repositories = repos
            self.repositoryTableView.reloadData()
        })
        self.searchBar.resignFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.networkController.isAuthenticated() == false {
            self.networkController.requestOAuthAccess()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.repositories != nil {
            return self.repositories.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = repositoryTableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as RepoCell
        let singleRepo = repositories?[indexPath.row]
        
        // use some part of repo info to populate the cell
        if singleRepo?.name != nil {
            cell.repoLabel?.text = singleRepo?.name
        }
        
        return cell
        
    }
}
