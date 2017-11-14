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
    case showCellCreator
    case showBuildSave(buildCellsData: [BuildCellData], name: String?)
    case showLoadedBuild(buildCellsData: [BuildCellData], name: String)
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
    
    var sc2BuildCreate: SC2BuildCreateViewController {
        let vm = SC2BuildCreateViewModel(flowDelegate: self)
        let vc = SC2BuildCreateViewController()
        vc.viewModel = vm
        return vc
    }
    
    var sc2BuildCellCreator: SC2BuildCellCreatorViewController {
        let vm = SC2BuildCellCreatorViewModel(flowDelegate: self)
        let vc = SC2BuildCellCreatorViewController()
        vm.viewControllerDelegate = vc
        vc.viewModel = vm
        return vc
    }
    
    var sc2BuildSave: SC2BuildSaveViewController {
        let vm = SC2BuildSaveViewModel(flowDelegate: self)
        let vc = SC2BuildSaveViewController()
        vc.viewModel = vm
        return vc
    }
    
    var sc2BuildLoad: SC2BuildLoadViewController {
        let vm = SC2BuildLoadViewModel(flowDelegate: self)
        let vc = SC2BuildLoadViewController()
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
                self.push(viewController: self.sc2BuildCreate)
            case .showLoaded:
                self.push(viewController: self.sc2BuildLoad)
            case .showCellCreator:
                self.present(viewController: self.sc2BuildCellCreator, completion: nil)
            case .showBuildSave(let data, let name):
                let buildSaveController = self.sc2BuildSave
                buildSaveController.viewModel.nameOfBuild = name
                buildSaveController.viewModel.buildCellsData = data
                self.push(viewController: buildSaveController)
            case .showLoadedBuild(let data, let name):
                let buildCreateController = self.sc2BuildCreate
                buildCreateController.viewModel.nameOfBuild = name
                buildCreateController.viewModel.buildCells.value = data
                self.push(viewController: buildCreateController)
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
