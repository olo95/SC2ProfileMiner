//
//  SC2CompareCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2CompareCoordinator: Coordinating {
    var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    
    var sc2Compare: SC2CompareViewController {
        let vm = SC2CompareViewModel(flowDelegate: self)
        let vc = SC2CompareViewController()
        vc.viewModel = vm
        return vc
    }
    
    func start() {
        navigationController.setViewControllers([sc2Compare], animated: true)
    }
    
    required init(parent: Coordinating?) {
        self.parent = parent
    }
    
    
}
