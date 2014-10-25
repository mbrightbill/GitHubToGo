//
//  UserSearchViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/23/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    var networkController : NetworkController!
    var users : [User]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.userSearchBar.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        self.userSearchBar.placeholder = "Search Users"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.networkController.isAuthenticated() == false {
            self.networkController.requestOAuthAccess()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if users != nil {
            return users!.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCollectionViewCell
        cell.userNameLabel.text = self.users![indexPath.row].userName
        
        if self.users![indexPath.row].userImage != nil {
            cell.imageView.image = self.users![indexPath.row].userImage
        } else {
            self.networkController.convertURLStringToUsableImage(self.users[indexPath.row], completionHandler: { (usableImage) -> (Void) in
                if let cellForImage = self.collectionView.cellForItemAtIndexPath(indexPath) as? UserCollectionViewCell {
                    cellForImage.imageView.image = usableImage
                }
            })
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedUser = users[indexPath.row] as User
        let userDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_DETAIL") as UserDetailViewController
        userDetailVC.user = selectedUser
        self.navigationController?.pushViewController(userDetailVC, animated: true)
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.networkController.fetchUsersUsingSearch(searchBar.text, completionHandler: { (users) -> (Void) in
            self.users = users
            self.collectionView.reloadData()
        })
        self.userSearchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        println(text)
        return text.validate()
    }
}
