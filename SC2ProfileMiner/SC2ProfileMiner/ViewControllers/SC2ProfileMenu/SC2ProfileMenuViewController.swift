//
//  SC2ProfileMenuViewController.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 24.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

enum GraphType {
    case matchHistory
    case seasonWinsLosses
}

class SC2ProfileMenuViewController: UIViewController {
    
    @IBOutlet weak var showProfileGraphsButton: UIButton!
    
    @IBOutlet weak var seasonTotalGamesNumberLabel: UILabel!
    @IBOutlet weak var highestOneVOneRankTitleLabel: UILabel!
    @IBOutlet weak var careerTotalGamesNumberLabel: UILabel!
    
    @IBOutlet weak var protossWinsNumberLabel: UILabel!
    @IBOutlet weak var zergWinsNumberLabel: UILabel!
    @IBOutlet weak var terranWinsNumberLabel: UILabel!
    
    @IBOutlet weak var primaryRaceLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var clanTagLabel: UILabel!
    
    var viewModel: SC2ProfileMenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        bindUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SC2 Profile Miner"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorTheme.appTheme.base]
    }
    
    private func setupUI() {
        showProfileGraphsButton.layer.add(CABasicAnimation().pulseAnimation(duration: 2), forKey: "animateOpacity")
    }
    
    private func bindUI() {
        viewModel.profileName.bind(to: profileNameLabel.rx.text).disposed(by: viewModel.bag)
        viewModel.primaryRace.bind(to: primaryRaceLabel.rx.text).disposed(by: viewModel.bag)
        viewModel.clanTag.bind(to: clanTagLabel.rx.text).disposed(by: viewModel.bag)
        
        let racesObservable = viewModel.raceWins
        racesObservable.map( { return String(describing: $0.terran ?? -1) }).bind(to: terranWinsNumberLabel.rx.text).disposed(by: viewModel.bag)
        racesObservable.map( { return String(describing: $0.zerg ?? -1) }).bind(to: zergWinsNumberLabel.rx.text).disposed(by: viewModel.bag)
        racesObservable.map( { return String(describing: $0.protoss ?? -1) }).bind(to: protossWinsNumberLabel.rx.text).disposed(by: viewModel.bag)
        
        let gamesObservable = viewModel.gamesPlayed
        gamesObservable.map( { return String(describing: $0.season ?? -1) }).bind(to: seasonTotalGamesNumberLabel.rx.text).disposed(by: viewModel.bag)
        gamesObservable.map( { return String(describing: $0.total ?? -1) }).bind(to: careerTotalGamesNumberLabel.rx.text).disposed(by: viewModel.bag)
        
        viewModel.highestOneVOneRank.bind(to: highestOneVOneRankTitleLabel.rx.text).disposed(by: viewModel.bag)
        
        showProfileGraphsButton.rx.tap.subscribe( onNext: { _ in
            let graphChoiceAlert = UIAlertController(title: "Choose graph:", message: nil, preferredStyle: .actionSheet)
            graphChoiceAlert.addAction(UIAlertAction(title: "Last match history",
                                                      style: .default,
                                                      handler: { _ in
                                                        self.viewModel.flowDelegate.profileRouter.onNext(.showGraph(data: self.viewModel.profileData, type: .matchHistory))
                                                        
            }))
            graphChoiceAlert.addAction(UIAlertAction(title: "Wins and losses",
                                                     style: .default,
                                                     handler: { _ in
                                                        self.viewModel.flowDelegate.profileRouter.onNext(.showGraph(data: self.viewModel.profileData, type: .seasonWinsLosses))
                                                        
            }))
            self.viewModel.flowDelegate.present(viewController: graphChoiceAlert, completion: nil)
        }).disposed(by: viewModel.bag)
    }

}
