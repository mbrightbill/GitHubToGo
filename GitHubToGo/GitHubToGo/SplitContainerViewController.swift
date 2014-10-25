//
//  SplitContainerViewController.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/20/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class SplitContainerViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let splitVC = self.childViewControllers[0] as UISplitViewController
        splitVC.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // only gets called if this VC is the delegate
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return true
    }
}
