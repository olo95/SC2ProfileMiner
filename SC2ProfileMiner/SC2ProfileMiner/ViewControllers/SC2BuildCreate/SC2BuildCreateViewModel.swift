//
//  SC2BuildCreateViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 07.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

typealias BuildCellData = (time: String, action: String, description: String)

class SC2BuildCreateViewModel {
    
    var flowDelegate: SC2BuildCoordinator!
    var buildCells = Variable<[BuildCellData]>([("","","")])
    var newBuildCell = PublishSubject<BuildCellData>()
    let bag = DisposeBag()
    
    init(flowDelegate: SC2BuildCoordinator) {
        self.flowDelegate = flowDelegate
        bindSubjects()
    }
    
    private func bindSubjects() {
        newBuildCell.subscribe( onNext: { newCell in
                self.buildCells.value.append(newCell)
        }).disposed(by: bag)
    }
}
