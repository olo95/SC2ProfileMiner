//
//  SC2CompareResultViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 02.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxCocoa

class SC2CompareResultViewController: UIViewController {
    
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var winnerPossibilityValueLabel: UILabel!
    @IBOutlet weak var winnerPossibilityLabel: UILabel!
    
    var viewModel: SC2CompareResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bindUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.base]
    }
    
    private func bindUI() {
        viewModel.winnerName.bind(to: winnerNameLabel.rx.text).disposed(by: viewModel.bag)
        viewModel.winPossibility.bind(to: winnerPossibilityValueLabel.rx.text).disposed(by: viewModel.bag)
    }
}
