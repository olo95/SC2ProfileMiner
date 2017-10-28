//
//  SC2CompareViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class SC2CompareViewController: UIViewController {

    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var profileTwoNameTextField: UITextField!
    @IBOutlet weak var profileOneNameTextField: UITextField!
    @IBOutlet weak var profileTwoIdTextField: UITextField!
    @IBOutlet weak var profileOneIdTextField: UITextField!
    var viewModel: SC2CompareViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(showDrawer))
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem?.tintColor = ColorTheme.appTheme.gray
    }

    @objc
    private func showDrawer() {
        viewModel.flowDelegate.showDrawer()
    }
}
