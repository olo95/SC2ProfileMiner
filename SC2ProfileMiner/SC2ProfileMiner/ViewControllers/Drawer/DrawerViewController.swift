//
//  DrawerViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class DrawerViewController: UIViewController {

    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var buildImageView: UIImageView!
    @IBOutlet weak var compareImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var sc2CreateButton: UIButton!
    @IBOutlet weak var sc2CompareButton: UIButton!
    @IBOutlet weak var sc2ProfileButton: UIButton!
    
    @IBOutlet weak var leftBoundView: UIView!
    @IBOutlet weak var splitterConstraint: NSLayoutConstraint!
    
    var flowDelegate: Coordinating!
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImages()
        setButtons()
    }
    
    private func setImages() {
        let colorOfImage = ColorTheme.appTheme.lightGray
        buildImageView.image = buildImageView.image!.withRenderingMode(.alwaysTemplate)
        buildImageView.tintColor = colorOfImage
        compareImageView.image = compareImageView.image!.withRenderingMode(.alwaysTemplate)
        compareImageView.tintColor = colorOfImage
        profileImageView.image = profileImageView.image!.withRenderingMode(.alwaysTemplate)
        profileImageView.tintColor = colorOfImage
    }
    
    private func setButtons() {
        sc2ProfileButton.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: {
                let sc2ProfileCoordinator = SC2ProfileCoordinator(parent: self.flowDelegate.rootCoordinator())
                self.flowDelegate.addNew(coordinator: sc2ProfileCoordinator, fromRoot: true)
            })
        }).disposed(by: bag)
        sc2CompareButton.rx.tap.subscribe(onNext: { _ in
            let sc2CompareCoordinator = SC2CompareCoordinator(parent: self.flowDelegate.rootCoordinator())
            self.flowDelegate.addNew(coordinator: sc2CompareCoordinator, fromRoot: true)
        }).disposed(by: bag)
        sc2CreateButton.rx.tap.subscribe(onNext: { _ in
            let sc2CreateCoordinator = SC2BuildCoordinator(parent: self.flowDelegate.rootCoordinator())
            self.flowDelegate.addNew(coordinator: sc2CreateCoordinator, fromRoot: true)
        }).disposed(by: bag)
    }
}
