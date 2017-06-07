//
//  CustomModalSegue.swift
//
//  Created by Ilya Filinovich on 06.06.17.
//

import UIKit

class CustomModalSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var transitionDuration: TimeInterval = 0.2
    
    var unwindTransitionDuration: TimeInterval = 0.3
    
    override func perform() {
        destination.transitioningDelegate = self
        
        super.perform()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to) == destination {
            return transitionDuration
        }
        else {
            return unwindTransitionDuration
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let distView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        if let toView = distView, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) == destination {
            // Presenting
            UIView.performWithoutAnimation {
                containerView.addSubview(toView)
                toView.center = CGPoint(x: containerView.center.x, y: 0 + 2 * containerView.center.y)
            }
            let transitionContextDuration = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: transitionContextDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                toView.center = CGPoint(x: containerView.center.x, y: containerView.center.y)
            }, completion: { success in
                transitionContext.completeTransition(success)
            })
        }
        else {
            // Dismissing
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            
            let transitionContextDuration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: transitionContextDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                fromView.center = CGPoint(x: fromView.center.x, y: 0 + 2 * fromView.center.y)
            }, completion: { success in
                transitionContext.completeTransition(success)
            })
        }
    }
}

