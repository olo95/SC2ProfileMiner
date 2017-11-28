//
//  SC2ProfileViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa
import PKHUD

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
        
        profileIdTextField.rx.text.subscribe( onNext: { _ in
            self.view.addSubview(DropDownPicker(frame: CGRect(origin: self.view.frame.origin, size: self.view.bounds.size), typeOfData: .ids))
        }).disposed(by: viewModel.bag)
        
        profileNameTextField.rx.text.subscribe( onNext: { _ in
            self.view.addSubview(DropDownPicker(frame: CGRect(origin: self.view.frame.origin, size: self.view.bounds.size), typeOfData: .names))
        }).disposed(by: viewModel.bag)
        
        loadProfileButton.rx.tap.subscribe( onNext: { _ in
            self.profileIdTextField.sendActions(for: .valueChanged)
            self.profileNameTextField.sendActions(for: .valueChanged)
        }).disposed(by: viewModel.bag)
        
        let observable = Observable.combineLatest(profileIdTextField.rx.text, profileNameTextField.rx.text)
            .filter({ return $0.0 != nil && $0.1 != nil })
            .map { return ($0.0!, $0.1!) }
            .share()
        
        observable
            .filter { return !$0.0.isEmpty && !$0.1.isEmpty }
            .sample(loadProfileButton.rx.tap)
            .subscribe( onNext: {
                self.viewModel.downloadProfile(with: $0.0, name: $0.1)
            }).disposed(by: viewModel.bag)
        
        observable
            .filter { return $0.0.isEmpty || $0.1.isEmpty }
            .sample(loadProfileButton.rx.tap)
            .subscribe( onNext: { _ in
                HUD.flash(.labeledError(title: "Error", subtitle: "Some fields are not filled"), delay: 1.0)
            }).disposed(by: viewModel.bag)
    }
}
