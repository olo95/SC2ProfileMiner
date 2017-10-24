//
//  DrawerTransitionManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

enum DrawerRouter {
    case none
    case shown
    case hidden
}

class DrawerTransitionManager: TransitionManager {
    
    var lastTransitionContext: UIViewControllerContextTransitioning!
    var lastBackground: UIView!
    
    fileprivate func show(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? DrawerViewController else {
                return
        }
        lastTransitionContext = transitionContext
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapContainerView))
//        gestureRecognizer.delegate = self
        let containerView = transitionContext.containerView
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        lastBackground = snapshot!
        toVC.view.addGestureRecognizer(gestureRecognizer)
        snapshot?.frame = originFrame
        toVC.drawerView.frame.origin.x -= fromVC.view.frame.maxX
        
        //containerView.addSubview(fromVC.view)
        //toVC.view.addSubview(fromVC.view)
        fromVC.view.frame = containerView.frame
        containerView.addSubview(snapshot!)
        containerView.addSubview(toVC.view)
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
                    snapshot?.layer.opacity = 0.8
                    toVC.drawerView.frame = CGRect(x: containerView.frame.origin.x - containerView.frame.width / 2, y: containerView.frame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
                })
        },
            completion: { _ in
                toVC.drawerView.frame = CGRect(x: containerView.frame.origin.x - containerView.frame.width / 2, y: containerView.frame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
                self.lastBackground.frame = UIScreen.main.bounds
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    
    @objc
    fileprivate func didTapContainerView() {
        (lastTransitionContext.viewController(forKey: .to) as! DrawerViewController).dismiss(animated: true)
    }
    
    fileprivate func hide(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? DrawerViewController,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        lastTransitionContext = transitionContext
        let containerView = transitionContext.containerView
        //let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
//        snapshot?.frame = originFrame
        fromVC.view.frame.origin.x -= toVC.view.frame.maxX
        
        //containerView.addSubview(fromVC.view)
        //toVC.view.addSubview(fromVC.view)
        fromVC.view.frame = containerView.frame
//        containerView.addSubview(snapshot!)
        //containerView.addSubview(toVC.view)
        //toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1 / 1, animations: {
                    //fromVC.view.frame.origin.x -= fromVC.view.frame.maxX / 3
                    toVC.view.alpha = 1.0
                    self.lastBackground.layer.opacity = 1.0
//                    toVC.view.frame = CGRect(x: containerView.frame.origin.x - containerView.frame.width / 2, y: containerView.frame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
                    toVC.view.frame.origin.x -= fromVC.view.frame.maxX
                })
        },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

extension DrawerTransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let _ = transitionContext.viewController(forKey: .to) as? DrawerViewController { // Drawer is appearing
            show(using: transitionContext)
        } else if let _ = transitionContext.viewController(forKey: .from) as? DrawerViewController { // Drawer is disappearing
            hide(using: transitionContext)
        }
    }
    
    func animationEnded(_: Bool) {}
}

extension DrawerTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension DrawerTransitionManager: UIGestureRecognizerDelegate {}
