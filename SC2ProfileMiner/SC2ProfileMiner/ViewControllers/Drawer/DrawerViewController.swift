//
//  DrawerViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    @IBOutlet weak var buildImageView: UIImageView!
    @IBOutlet weak var compareImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var sc2CreateButton: UIButton!
    @IBOutlet weak var sc2CompareButton: UIButton!
    @IBOutlet weak var sc2ProfileButton: UIButton!
    
    @IBOutlet weak var leftBoundView: UIView!
    @IBOutlet weak var splitterConstraint: NSLayoutConstraint!
    
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
        
    }
}
