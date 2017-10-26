//
//  SC2ProfileViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2ProfileViewModel {
    var flowDelegate: SC2ProfileCoordinator!
    let bag = DisposeBag()
    
    func downloadProfile(with id: String, name: String) {
        SC2Networker.GET(url: SC2Router.getUrl(parameters: SC2Url(name: name, id: id), method: .profile)) { (result: SC2Profile) in
            self.flowDelegate.profileRouter.onNext(.showProfile(data: result))
        }
    }
    
    init(flowDelegate: SC2ProfileCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
