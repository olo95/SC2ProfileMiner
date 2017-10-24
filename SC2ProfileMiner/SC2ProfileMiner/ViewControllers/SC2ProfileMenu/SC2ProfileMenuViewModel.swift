//
//  SC2ProfileMenuViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 24.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2ProfileMenuViewModel {
    
    var flowDelegate: SC2ProfileCoordinator!
    var profileData: SC2Profile!
    
    init(flowDelegate: SC2ProfileCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
