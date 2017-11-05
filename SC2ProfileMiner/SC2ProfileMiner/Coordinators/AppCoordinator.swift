//
//  AppCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit
import RxSwift

enum MainMenuChoice {
    case none
    case sc2Profile
    case sc2Compare
    case sc2Build
}

class AppCoordinator: Coordinating {
   
    let window = UIWindow(frame: UIScreen.main.bounds)
    var appTransitionManager: AppTransitionManager!
    
    required init(parent: Coordinating?) {
        self.parent = parent
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        appTransitionManager = AppTransitionManager(coordinator: self)
        setMenuRouter()
    }
    
    private func setMenuRouter() {
        menuChoice.subscribe(onNext: { choice in
            switch choice {
            case .sc2Profile:
                self.addNew(coordinator: SC2ProfileCoordinator(parent: self), fromRoot: true)
            case .sc2Compare:
                self.addNew(coordinator: SC2CompareCoordinator(parent: self), fromRoot: true)
            case .sc2Build:
                self.addNew(coordinator: SC2BuildCoordinator(parent: self), fromRoot: true)
            case .none:
                break
            }
        }).disposed(by: bag)
    }
    
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    
    func start() {
        navigationController.setViewControllers([mainMenuViewController], animated: true)
    }
    
    func addNew(coordinator: Coordinating, fromRoot: Bool) {
        childCoordinators.removeAll()
        childCoordinators.append(coordinator)
        coordinator.start()
        coordinator.navigationController.transitioningDelegate = appTransitionManager
        self.present(viewController: coordinator.navigationController, completion: nil)
    }

    
    var menuChoice = BehaviorSubject<MainMenuChoice>(value: .none)
    let bag = DisposeBag()
    
    var mainMenuViewController: MainMenuViewController {
        let vm = MainMenuViewModel(flowDelegate: self)
        let vc = MainMenuViewController()
        vc.viewModel = vm
        return vc
    }
}
