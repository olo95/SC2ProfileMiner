//
//  TransitionManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    
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
