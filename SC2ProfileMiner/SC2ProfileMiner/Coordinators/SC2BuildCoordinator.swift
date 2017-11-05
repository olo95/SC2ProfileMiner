//
//  SC2BuildCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2BuildCoordinator: Coordinating {
    
    var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    
    var sc2Build: SC2BuildViewController {
        let vm = SC2BuildViewModel(flowDelegate: self)
        let vc = SC2BuildViewController()
        vc.viewModel = vm
        return vc
    }
    
    func start() {
        navigationController.setViewControllers([sc2Build], animated: true)
    }
    
    func addNew(coordinator: Coordinating, fromRoot: Bool) {
        if fromRoot && parent != nil {
            navigationController.dismiss(animated: false, completion: {
                self.childCoordinators.removeAll()
                self.parent?.addNew(coordinator: coordinator, fromRoot: fromRoot)
            })
        } else {
            childCoordinators.append(coordinator)
            coordinator.start()
            self.present(viewController: coordinator.navigationController, completion: nil)
        }
    }
    
    required init(parent: Coordinating?) {
        self.parent = parent
    }
    
    func showDrawer() {
        let drawerCoordinator = DrawerCoordinator(parent: self)
        drawerCoordinator.navigationController = self.navigationController
        drawerCoordinator.start()
    }
}
