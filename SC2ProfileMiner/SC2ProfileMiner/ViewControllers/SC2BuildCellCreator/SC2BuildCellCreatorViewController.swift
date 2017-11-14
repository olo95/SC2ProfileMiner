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
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var actionTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var viewModel: SC2BuildCellCreatorViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        setupButtons()
    }
    
    private func setupButtons() {
        addButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
        cancelButton.layer.add(CABasicAnimation().pulseAnimation(duration: 1.5), forKey: "animateOpacity")
    }
    
    private func bindUI() {
        cancelButton.rx.tap.subscribe( onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: viewModel.bag)
        
        Observable.combineLatest(timeTextField.rx.text, actionTextField.rx.text, descriptionTextField.rx.text)
            .map { return ($0.0, $0.1, $0.2) }
            .filter { return $0.0 != nil && $0.1 != nil && $0.2 != nil }
            .sample(addButton.rx.tap)
            .subscribe( onNext: {
                self.viewModel.newBuildElement.onNext((time: $0.0!, action: $0.1!, description: $0.2!))
                self.viewModel.flowDelegate.dismiss(viewController: self, completion: nil)
            }).disposed(by: viewModel.bag)
    }

}
