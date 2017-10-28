//
//  SC2CompareViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2CompareViewModel {
    
    var flowDelegate: SC2CompareCoordinator!
    var sc2ProfileOne: SC2Profile!
    var sc2ProfileTwo: SC2Profile!
    let bag = DisposeBag()

    init(flowDelegate: SC2CompareCoordinator) {
        self.flowDelegate = flowDelegate
    }
    
    func compareProfiles(names: (String, String), ids: (String, String)) {
        
    }
}
