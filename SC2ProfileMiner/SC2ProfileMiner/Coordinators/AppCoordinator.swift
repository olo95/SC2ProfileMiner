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
    required init(parent: Coordinating?) {
        self.parent = parent
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        menuChoice.subscribe( onNext: { choice in
            switch choice {
            case .sc2Profile:
                let profileCoordinator = SC2ProfileCoordinator(parent: self)
                self.childCoordinators.append(profileCoordinator)
                profileCoordinator.start()
                self.present(viewController: profileCoordinator.navigationController, completion: nil)
            case .sc2Compare:
                let compareCoordinator = SC2CompareCoordinator(parent: self)
                self.childCoordinators.append(compareCoordinator)
                compareCoordinator.start()
                self.present(viewController: compareCoordinator.navigationController, completion: nil)
            case .sc2Build:
                let buildCoordinator = SC2BuildCoordinator(parent: self)
                self.childCoordinators.append(buildCoordinator)
                buildCoordinator.start()
                self.present(viewController: buildCoordinator.navigationController, completion: nil)
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
    
    var menuChoice = BehaviorSubject<MainMenuChoice>(value: .none)
    let bag = DisposeBag()
    
    var mainMenuViewController: MainMenuViewController {
        let vm = MainMenuViewModel(flowDelegate: self)
        let vc = MainMenuViewController()
        vc.viewModel = vm
        return vc
    }
}
