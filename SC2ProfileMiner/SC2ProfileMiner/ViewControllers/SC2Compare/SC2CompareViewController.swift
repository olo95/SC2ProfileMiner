//
//  SC2CompareViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa
import PKHUD

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
        setupButtons()
        bindUI()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(showDrawer))
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem?.tintColor = ColorTheme.appTheme.base
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.base]
    }
    
    private func setupButtons() {
        compareButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
    }
    
    private func bindUI() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        let observable = Observable.combineLatest(profileOneIdTextField.rx.text, profileTwoIdTextField.rx.text, profileOneNameTextField.rx.text, profileTwoNameTextField.rx.text)
            .filter { return $0.0 != nil && $0.1 != nil && $0.2 != nil && $0.3 != nil }
            .map { return (($0.0!, $0.1!), ($0.2!, $0.3!)) }
        
        observable
            .filter { return !$0.0.0.isEmpty && !$0.0.1.isEmpty && !$0.1.0.isEmpty && !$0.1.1.isEmpty }
            .sample(compareButton.rx.tap)
            .subscribe( onNext: {
                self.viewModel.compareProfiles(ids: ($0.0.0, $0.0.1), names: ($0.1.0, $0.1.1))
            }).disposed(by: viewModel.bag)
        
        observable
            .sample(compareButton.rx.tap)
            .subscribe( onNext: { _ in
                HUD.flash(.labeledError(title: "Error", subtitle: "Some fields are not filled"), delay: 1.0)
            }).disposed(by: viewModel.bag)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func showDrawer() {
        viewModel.flowDelegate.showDrawer()
    }
}
