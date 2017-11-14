//
//  SC2BuildCellCreatorViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 07.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2BuildCellCreatorViewModel {
    
    var flowDelegate: SC2BuildCoordinator!
    var viewControllerDelegate: SC2BuildCellCreatorViewController!
    var bag = DisposeBag()
    var newBuildElement = BehaviorSubject<BuildCellData>(value: ("","",""))
    
    init(flowDelegate: SC2BuildCoordinator) {
       self.flowDelegate = flowDelegate
        bindSubjects()
    }
    
    private func bindSubjects() {
        newBuildElement
            .filter { return !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty }
            .subscribe( onNext: { newElement in
                self.flowDelegate.sc2BuildCreate.viewModel.newBuildCell.onNext(newElement)
        }).disposed(by: bag)
    }
}
