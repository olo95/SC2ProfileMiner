//
//  SC2ProfileCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2ProfileCoordinator: Coordinating {
    func addNew(coordinator: Coordinating) {
        let coordinator = SC2ProfileCoordinator(parent: self)
        childCoordinators.append(coordinator)
        coordinator.start()
        self.present(viewController: coordinator.navigationController, completion: nil)
    }
    
    var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    
    var sc2Profile: SC2ProfileViewController {
        let vm = SC2ProfileViewModel(flowDelegate: self)
        let vc = SC2ProfileViewController()
        vc.viewModel = vm
        return vc
    }
    
    func start() {
        navigationController.setViewControllers([sc2Profile], animated: true)
    }
    
    required init(parent: Coordinating?) {
        self.parent = parent
    }
    
    
}
