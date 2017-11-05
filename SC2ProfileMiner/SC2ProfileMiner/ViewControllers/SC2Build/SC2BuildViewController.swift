//
//  SC2BuildViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class SC2BuildViewController: UIViewController {

    @IBOutlet weak var loadSavedBuildButton: UIButton!
    @IBOutlet weak var createNewBuildButton: UIButton!
    var viewModel: SC2BuildViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        bindUI()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(showDrawer))
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem?.tintColor = ColorTheme.appTheme.gray
    }
    
    private func bindUI() {
        loadSavedBuildButton.rx.tap.subscribe( onNext: { _ in
            self.viewModel.flowDelegate.buildRouter.onNext(.showLoaded)
        }).disposed(by: viewModel.bag)
        
        createNewBuildButton.rx.tap.subscribe( onNext: { _ in
            self.viewModel.flowDelegate.buildRouter.onNext(.showCreateNew)
        }).disposed(by: viewModel.bag)
    }

    @objc
    private func showDrawer() {
        viewModel.flowDelegate.showDrawer()
    }
}
