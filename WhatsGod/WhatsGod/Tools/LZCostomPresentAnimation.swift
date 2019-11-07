//
//  LZCostomPresentAnimation.swift
//  WhatsGod
//
//  Created by imac on 11/7/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit

class LZCostomPresentAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    public var dismiss = false
    private var toController:UIViewController?
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
       
        self.presentAnimation(transitionContext: transitionContext,dismiss: self.dismiss)
        
    }
    

    public func presentAnimation(transitionContext:UIViewControllerContextTransitioning, dismiss:Bool){
      
        let fromController = transitionContext.viewController(forKey: .from)
        self.toController = transitionContext.viewController(forKey: .to)
        
        let toView = self.toController?.view
        let fromView = fromController?.view
        self.toController?.beginAppearanceTransition(true, animated: true)
        
        let containerView = transitionContext.containerView
        
        let frame = fromView?.frame
        var screenFrame = frame
        screenFrame!.origin.y = (screenFrame?.size.height)!
        toView?.frame = screenFrame!
        containerView.insertSubview(toView!, aboveSubview: fromView!)
        
        if !dismiss {
            toView?.frame = transitionContext.initialFrame(for: fromController!)
            screenFrame = toView?.frame
            screenFrame?.origin.y = (toView?.frame.size.height)!
        }
        
        var t1 = CATransform3DIdentity
        t1.m34 = 1.0 / -1000
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        t1 = CATransform3DRotate(t1, CGFloat(15.0 * M_PI / 180.0), 1, 0, 0)
        
        var t2 = CATransform3DIdentity
        t2.m34 = 1.0 / -1000
        t2 = CATransform3DScale(t2, 0.8, 0.8, 1)
        t2 = CATransform3DTranslate(t2, 0, -(fromView?.frame.size.height)! * 0.08, 0)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic, animations: {
            if dismiss{
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                    fromView?.layer.transform = t1
                    fromView?.alpha = 0.5
                }
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.5) {
                    fromView?.layer.transform = t2
                }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    toView?.frame = frame!
                }
            }else{
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                    fromView!.frame = screenFrame!
                }
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.5) {
                    
                    toView?.layer.transform = t1
                    toView?.alpha = 1.0
                }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    toView?.layer.transform = CATransform3DIdentity
                }
            }
        }) { (isBool) in
         
            transitionContext.completeTransition(transitionContext.transitionWasCancelled)
            
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if !transitionCompleted{
            self.toController?.view.transform = CGAffineTransform.identity
        }
    }
}
