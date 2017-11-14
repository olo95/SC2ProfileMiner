//
//  SC2BuildSave.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 14.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2BuildSaveViewModel {
    
    var flowDelegate: SC2BuildCoordinator!
    var buildCellsData: [BuildCellData] = []
    var nameOfBuild: String?
    let bag = DisposeBag()
    
    init(flowDelegate: SC2BuildCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
