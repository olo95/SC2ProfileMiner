//
//  SC2ProfileCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

enum DrawerRouter {
    case none
    case shown
    case hidden
}

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
    
    var drawerRouter = BehaviorSubject<DrawerRouter>(value: .none)
    let bag = DisposeBag()
    
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
        setDrawerRouter()
    }
    
    private func setDrawerRouter() {
        drawerRouter.subscribe( onNext: { state in
            switch state {
            case .shown:
                let drawerController = DrawerViewController()
                let drawerTransitionManager = DrawerTransitionManager(coordinator: self)
                drawerController.transitioningDelegate = drawerTransitionManager
                self.present(viewController: drawerController, completion: nil)
            case .hidden:
                break
            case .none:
                break
            }
        }).disposed(by: bag)
    }
    
}
