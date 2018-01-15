//
//  SC2BuildSaveViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 14.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2BuildSaveViewController: UIViewController {

    @IBOutlet weak var saveBuildButton: UIButton!
    @IBOutlet weak var buildNameTextField: UITextField!
    var viewModel: SC2BuildSaveViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = ColorTheme.appTheme.base
        saveBuildButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
        buildNameTextField.text = viewModel.nameOfBuild
    }
    
    private func bindUI() {
        buildNameTextField.rx.text
            .filter { return $0 != nil }
            .sample(saveBuildButton.rx.tap)
            .subscribe( onNext: { name in
                UserDefaultsManager.saveBuild(with: self.viewModel.buildCellsData, name: name!)
                self.viewModel.flowDelegate.navigationController.popViewController(animated: true)
            }).disposed(by: viewModel.bag)
    }

}
