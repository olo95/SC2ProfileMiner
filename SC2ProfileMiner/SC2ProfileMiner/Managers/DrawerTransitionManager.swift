//
//  DrawerTransitionManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class DrawerTransitionManager: TransitionManager {
    
}

extension DrawerTransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        let containerView = transitionContext.containerView
//        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
//        snapshot?.frame = originFrame
        toVC.view.frame.origin.x -= fromVC.view.frame.maxX
        
        containerView.addSubview(fromVC.view)
        toVC.view.sendSubview(toBack: fromVC.view)
        containerView.addSubview(toVC.view)
        //containerView.addSubview(snapshot!)
        //toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1 / 1, animations: {
                    fromVC.view.frame.origin.x += fromVC.view.frame.maxX / 3
                    toVC.view.alpha = 1.0
                    toVC.view.frame = CGRect(x: containerView.frame.origin.x - containerView.frame.width / 2, y: containerView.frame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
                })
        },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func animationEnded(_: Bool) {}
}

extension DrawerTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
