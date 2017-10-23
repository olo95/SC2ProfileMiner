//
//  DrawerCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 23.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxCocoa
import RxSwift

class DrawerCoordinator: Coordinating {
    
    var drawerController = DrawerViewController()
    var drawerTransitionManager = DrawerTransitionManager()
    
    var navigationController: UINavigationController = UINavigationController()
    
    var childCoordinators: [Coordinating] = []
    
    var parent: Coordinating?
    
    func start() {
        drawerController.transitioningDelegate = drawerTransitionManager
        navigationController.transitioningDelegate = drawerTransitionManager
        drawerController.flowDelegate = self
        drawerTransitionManager.coordinator = self
        present(viewController: drawerController, completion: nil)
    }
    
    func addNew(coordinator: Coordinating, fromRoot: Bool) {
        parent?.addNew(coordinator: coordinator, fromRoot: fromRoot)
    }
    
    required init(parent: Coordinating?) {
        self.parent = parent
    }
    
    
}
