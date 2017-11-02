//
//  SC2CompareResultViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 02.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift

class SC2CompareResultViewModel {
    
    var flowDelegate: SC2CompareCoordinator!
    let bag = DisposeBag()
    var compareResult: CompareResult!
    
    init(flowDelegate: SC2CompareCoordinator) {
        self.flowDelegate = flowDelegate
    }
    
    var winnerName: Observable<String> {
        return Observable.create { observer in
            observer.onNext(self.compareResult.winner)
            return Disposables.create()
        }
    }
    
    var winPossibility: Observable<String> {
        return Observable.create { observer in
            observer.onNext("\(self.compareResult.winPossibility) %")
            return Disposables.create()
        }
    }
}
