//
//  SC2ProfileCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2ProfileCoordinator: Coordinating {
    
    var drawerController: DrawerViewController!
    var drawerTransitionManager: DrawerTransitionManager!
    
    func addNew(coordinator: Coordinating, fromRoot: Bool) {
        if fromRoot && parent != nil {
            childCoordinators.removeAll()
            parent?.addNew(coordinator: coordinator, fromRoot: fromRoot)
        }
        
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
                let drawerCoordinator = DrawerCoordinator(parent: self)
                drawerCoordinator.navigationController = self.navigationController
                drawerCoordinator.start()
            case .hidden:
                break
            case .none:
                break
            }
        }).disposed(by: bag)
    }
    
}
