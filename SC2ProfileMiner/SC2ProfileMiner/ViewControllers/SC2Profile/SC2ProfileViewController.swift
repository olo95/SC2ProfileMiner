//
//  SC2ProfileViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2ProfileViewController: UIViewController {

    @IBOutlet weak var profileNameTextField: UITextField!
    @IBOutlet weak var profileIdTextField: UITextField!
    @IBOutlet weak var loadProfileButton: UIButton!
    var viewModel: SC2ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setButtons()
        bindUI()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(showDrawer))
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem?.tintColor = ColorTheme.appTheme.gray
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.gray]
    }
    
    @objc
    private func showDrawer() {
        viewModel.flowDelegate.showDrawer()
    }
    
    private func setButtons() {
        loadProfileButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
    }
    
    private func bindUI() {
        Observable.combineLatest(profileIdTextField.rx.text, profileNameTextField.rx.text)
            .map( { return ($0.0, $0.1)})
            .filter({ return $0.0 != nil && $0.1 != nil })
            .sample(loadProfileButton.rx.tap)
            .subscribe( onNext: {
                self.viewModel.downloadProfile(with: $0.0!, name: $0.1!)
            }).disposed(by: viewModel.bag)
    }
}
