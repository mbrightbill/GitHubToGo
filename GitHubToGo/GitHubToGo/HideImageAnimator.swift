//
//  HideImageAnimator.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/25/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class HideImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
 
    var origin: CGRect?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserDetailViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserSearchViewController
        
        let containerView = transitionContext.containerView()
        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)

        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in
            fromVC.view.frame = self.origin!
            fromVC.imageView.frame = fromVC.view.bounds
            toVC.view.alpha = 1.0
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
    }
}
