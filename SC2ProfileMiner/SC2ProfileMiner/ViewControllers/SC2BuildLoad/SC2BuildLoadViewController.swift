//
//  SC2BuildLoadViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 05.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class SC2BuildLoadViewController: UIViewController {

    @IBOutlet weak var loadBuildButton: UIButton!
    @IBOutlet weak var buildNameTextField: UITextField!
    
    var viewModel: SC2BuildLoadViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.base]
    }
    
    private func bindUI() {
        buildNameTextField.rx.text
            .filter { return $0 != nil }
            .sample(loadBuildButton.rx.tap)
            .subscribe( onNext: { name in
                let buildData = UserDefaultsManager.loadBuild(name: name!)
                self.viewModel.flowDelegate.navigationController.popViewController(animated: true)
                self.viewModel.flowDelegate.buildRouter.onNext(.showLoadedBuild(buildCellsData: buildData, name: name!))
            }).disposed(by: viewModel.bag)
    }
}
