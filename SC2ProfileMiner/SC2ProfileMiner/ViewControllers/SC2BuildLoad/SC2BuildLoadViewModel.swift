//
//  SC2BuildLoadViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 07.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2BuildLoadViewModel {
    
    var flowDelegate: SC2BuildCoordinator!
    let bag = DisposeBag()
    
    init(flowDelegate: SC2BuildCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
