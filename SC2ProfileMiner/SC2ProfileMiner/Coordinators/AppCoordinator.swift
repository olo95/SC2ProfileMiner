//
//  AppCoordinator.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinating {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    required init(parent: Coordinating?) {
        self.parent = parent
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    var childCoordinators: [Coordinating] = []
    var parent: Coordinating?
    
    var mainMenuViewController: MainMenuViewController {
        let mainMenuViewModel = MainMenuViewModel()
        let vc = MainMenuViewController()
        vc.viewModel = mainMenuViewModel
        return vc
    }
    func start() {
        navigationController.setViewControllers([mainMenuViewController], animated: true)
    }
}
