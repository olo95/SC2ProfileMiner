//
//  SC2BuildCellCreatorViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 07.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2BuildCellCreatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.gray]
    }

}
