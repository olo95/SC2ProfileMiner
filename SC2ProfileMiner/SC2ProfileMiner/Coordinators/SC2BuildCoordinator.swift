//
//  SC2BuildCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

enum SC2BuildRouter {
    case none
    case showCreateNew
    case showLoaded
}

class SC2BuildCoordinator: Coordinating {
    
    var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    var buildRouter = BehaviorSubject<SC2BuildRouter>(value: .none)
    
    var sc2Build: SC2BuildViewController {
        let vm = SC2BuildViewModel(flowDelegate: self)
        let vc = SC2BuildViewController()
        vc.viewModel = vm
        return vc
    }
    
    let bag = DisposeBag()
    
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
        setBuildRouter()
    }
    
    private func setBuildRouter() {
        buildRouter.subscribe( onNext: { choice in
            switch choice {
            case .showCreateNew:
                print("")
            case .showLoaded:
                print("")
            default:
                break
            }
        }).disposed(by: bag)
    }
    
    func showDrawer() {
        let drawerCoordinator = DrawerCoordinator(parent: self)
        drawerCoordinator.navigationController = self.navigationController
        drawerCoordinator.start()
    }
}
