//
//  SC2BuildViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2BuildViewModel {
    
    var flowDelegate: SC2BuildCoordinator!
    let bag = DisposeBag()
    
    init(flowDelegate: SC2BuildCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
