//
//  SC2ProfileCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

enum SC2ProfileRouter {
    case none
    case showProfile(data: SC2Profile)
}

class SC2ProfileCoordinator: Coordinating {
    
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
    let bag = DisposeBag()
    var profileRouter = BehaviorSubject<SC2ProfileRouter>(value: .none)
    
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
        setProfileRouter()
    }
    
    private func setProfileRouter() {
        profileRouter.subscribe( onNext: { choice in
            switch choice {
            case .showProfile(let profile):
                print(profile)
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
