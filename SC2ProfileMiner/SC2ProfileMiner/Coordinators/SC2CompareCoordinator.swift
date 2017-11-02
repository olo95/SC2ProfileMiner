//
//  SC2CompareCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

enum SC2CompareRouter {
    case none
    case showCompareResult(CompareResult)
}

class SC2CompareCoordinator: Coordinating {
    
    var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    var compareRouter = BehaviorSubject<SC2CompareRouter>(value: .none)
    let bag = DisposeBag()
    
    var sc2Compare: SC2CompareViewController {
        let vm = SC2CompareViewModel(flowDelegate: self)
        let vc = SC2CompareViewController()
        vc.viewModel = vm
        return vc
    }
    
    func start() {
        navigationController.setViewControllers([sc2Compare], animated: true)
    }
    
    func addNew(coordinator: Coordinating, fromRoot: Bool) {
        if fromRoot && parent != nil {
            childCoordinators.removeAll()
            parent?.addNew(coordinator: coordinator, fromRoot: fromRoot)
        }
        let coordinator = SC2ProfileCoordinator(parent: self)
        childCoordinators.append(coordinator)
        coordinator.start()
        self.present(viewController: coordinator.navigationController, completion: nil)
    }
    
    required init(parent: Coordinating?) {
        self.parent = parent
        setCompareRouter()
    }
    
    private func setCompareRouter() {
        compareRouter.subscribe( onNext: { choice in
            switch choice {
            case .showCompareResult(let result):
                print("Compare result view")
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
