//
//  AppTransitionManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//


import UIKit

class AppTransitionManager: NSObject {
    
    var coordinator: Coordinating!
    var blurredBackground: UIView?
    var visibleController: UIViewController?
    var originFrame: CGRect {
        return rootNavigationController.view.frame
    }
    
    var rootNavigationController: UINavigationController {
        return coordinator.navigationController
    }
    
    var topNavigationController: UINavigationController {
        guard let topNavCon = coordinator.childCoordinators.last?.navigationController else {
            return rootNavigationController
        }
        return topNavCon
    }
    
    init(coordinator: Coordinating) {
        self.coordinator = coordinator
    }
    
    override init() {}
    
    func addBlurredBackground(completion: (() -> ())? = nil) {
        guard let topViewController = coordinator.navigationController.viewControllers.last else { return }
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = topViewController.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurredBackground = blurEffectView
        visibleController = topViewController
        topViewController.view.addSubview(blurEffectView)
        
        blurEffectView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            blurEffectView.alpha = 1.0
            completion?()
        })
    }
    
    func removeBlurredBackground(completion: (() -> ())? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            self.blurredBackground?.alpha = 0.0
        }, completion: { _ in
            self.blurredBackground?.removeFromSuperview()
            completion?()
        })
    }
    
    func makeSnapshot() {
        let snapView = topNavigationController.view.snapshotView(afterScreenUpdates: true)
        rootNavigationController.view = snapView
    }
    
    func removeSnapshot() {
        rootNavigationController.view = nil
    }
}

extension AppTransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        let containerView = transitionContext.containerView
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = originFrame
        snapshot?.frame.origin.x -= originFrame.maxX
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1 / 1, animations: {
                    fromVC.view.frame.origin.x += fromVC.view.frame.maxX / 3
                    fromVC.view.alpha = 0.50
                    snapshot?.alpha = 1.0
                    snapshot?.frame = toVC.view.frame
                })
        },
            completion: { _ in
                toVC.view.isHidden = false
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func animationEnded(_: Bool) {
    }
}

extension AppTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

