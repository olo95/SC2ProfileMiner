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
    var profileOneLoaded = PublishSubject<Bool>()
    var profileTwoLoaded = PublishSubject<Bool>()

    init(flowDelegate: SC2CompareCoordinator) {
        self.flowDelegate = flowDelegate
        Observable.combineLatest(profileOneLoaded, profileTwoLoaded)
            .filter( { return ( $0 && $1 ) })
            .subscribe( onNext: { _ in
                self.setCompareResult()
            }).disposed(by: bag)
    }
    
    func compareProfiles(names: (String, String), ids: (String, String)) {
        SC2Networker.GET(url: SC2Router.getUrl(parameters: SC2Url(name: names.0, id: ids.0), method: .profile)) { (result: SC2Profile) in
            self.sc2ProfileOne = result
            self.profileOneLoaded.onNext(true)
        }
        
        SC2Networker.GET(url: SC2Router.getUrl(parameters: SC2Url(name: names.1, id: ids.1), method: .profile)) { (result: SC2Profile) in
            self.sc2ProfileTwo = result
            self.profileTwoLoaded.onNext(true)
        }
    }
    
    private func setCompareResult() {
        
    }
}
