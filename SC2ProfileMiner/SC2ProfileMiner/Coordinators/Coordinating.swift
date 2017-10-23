//
//  Coordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

protocol Coordinating {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinating] { get set }
    var parent: Coordinating? { get set }
    func rootCoordinator() -> Coordinating
    func present(viewController: UIViewController, completion: (() -> ())?)
    func dismiss(viewController: UIViewController, completion: (() -> ())?)
    func push(viewController: UIViewController)
    func start()
    func addNew(coordinator: Coordinating, fromRoot: Bool)
    
    init(parent: Coordinating?)
}

extension Coordinating {
    
    func rootCoordinator() -> Coordinating {
        if let parent = self.parent {
            return parent.rootCoordinator()
        } else {
            return self
        }
    }
    
    func present(viewController: UIViewController, completion: (() -> ())?) {
        navigationController.present(viewController, animated: true, completion: {
            completion?()
        })
    }
    
    func dismiss(viewController: UIViewController, completion: (() -> ())?) {
        viewController.dismiss(animated: true, completion: {
            completion?()
        })
    }
    
    func push(viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
