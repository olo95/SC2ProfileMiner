//
//  MainMenuViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var sc2ProfileButton: UIButton!
    @IBOutlet weak var sc2CompareButton: UIButton!
    @IBOutlet weak var sc2BuildButton: UIButton!
    
    @IBOutlet weak var sc2ProfileButtonArrow: UIImageView!
    @IBOutlet weak var sc2CompareButtonArrow: UIImageView!
    @IBOutlet weak var sc2BuildButtonArrow: UIImageView!
    var viewModel: MainMenuViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        setupUIArrows()
        setupUIButtons()
    }
    
    private func setupUIArrows() {
        let colorOfArrow = ColorTheme.appTheme.lightBase
        sc2ProfileButtonArrow.image = sc2ProfileButtonArrow.image!.withRenderingMode(.alwaysTemplate)
        sc2ProfileButtonArrow.tintColor = colorOfArrow
        sc2CompareButtonArrow.image = sc2CompareButtonArrow.image!.withRenderingMode(.alwaysTemplate)
        sc2CompareButtonArrow.tintColor = colorOfArrow
        sc2BuildButtonArrow.image = sc2BuildButtonArrow.image!.withRenderingMode(.alwaysTemplate)
        sc2BuildButtonArrow.tintColor = colorOfArrow
        
        sc2ProfileButtonArrow.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
        sc2CompareButtonArrow.layer.add(CABasicAnimation().pulseAnimation(duration: 1.5), forKey: "animateOpacity")
        sc2BuildButtonArrow.layer.add(CABasicAnimation().pulseAnimation(duration: 1), forKey: "animateOpacity")
    }
    
    private func setupUIButtons() {
        sc2ProfileButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
        sc2CompareButton.layer.add(CABasicAnimation().pulseAnimation(duration: 1.5), forKey: "animateOpacity")
        sc2BuildButton.layer.add(CABasicAnimation().pulseAnimation(duration: 1), forKey: "animateOpacity")
    }
    
    private func bindUI() {
        sc2ProfileButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.flowDelegate.menuChoice.onNext(.sc2Profile)
        }).disposed(by: viewModel.bag)
        
        sc2CompareButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.flowDelegate.menuChoice.onNext(.sc2Compare)
        }).disposed(by: viewModel.bag)
        
        sc2BuildButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.flowDelegate.menuChoice.onNext(.sc2Build)
        }).disposed(by: viewModel.bag)
    }

}
