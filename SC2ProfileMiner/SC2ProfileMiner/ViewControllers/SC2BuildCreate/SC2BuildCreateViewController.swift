//
//  SC2BuildCreateViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 05.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2BuildCreateViewController: UIViewController {

    @IBOutlet weak var buildTableView: UITableView!
    var viewModel: SC2BuildCreateViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.gray]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add build element", style: .done, target: self, action: #selector(createNewCell))
    }
    
    @objc
    private func createNewCell() {
        viewModel.flowDelegate.buildRouter.onNext(.showCellCreator)
    }

}
