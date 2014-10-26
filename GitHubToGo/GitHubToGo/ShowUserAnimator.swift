//
//  ShowUserAnimator.swift
//  GitHubToGo
//
//  Created by Matthew Brightbill on 10/25/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class ShowUserAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var origin: CGRect?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserSearchViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserDetailViewController
        let containerView = transitionContext.containerView()
        
        toVC.view.frame = self.origin!
        toVC.imageView.frame = toVC.view.bounds
        
        containerView.addSubview(toVC.view)
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            toVC.view.frame = fromVC.view.frame
            toVC.imageView.frame = toVC.view.bounds
            }) { (finished) -> Void in
                
                fromVC.view.alpha = 0.0
                transitionContext.completeTransition(finished)
        }
    }
}
