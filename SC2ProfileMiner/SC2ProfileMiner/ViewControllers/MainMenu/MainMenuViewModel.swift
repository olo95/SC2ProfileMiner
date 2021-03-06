//
//  MainMenuViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class MainMenuViewModel {
    
    var flowDelegate: AppCoordinator!
    let bag = DisposeBag()
    
    init(flowDelegate: AppCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
