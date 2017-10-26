//
//  SC2ProfileMenuViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 24.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

struct RaceWins {
    var terran: Int?
    var zerg: Int?
    var protoss: Int?
}

struct GamesPlayed {
    var total: Int?
    var season: Int?
}

class SC2ProfileMenuViewModel {
    
    var flowDelegate: SC2ProfileCoordinator!
    var profileData: SC2Profile!
    let bag = DisposeBag()
    
    var profileName: Observable<String> {
        return Observable.create( { observer in
            observer.onNext(self.profileData.displayName!)
            return Disposables.create()
        })
    }
    
    var primaryRace: Observable<String> {
        return Observable.create( { observer in
            observer.onNext((self.profileData.career?.primaryRace)!)
            return Disposables.create()
        })
    }
    
    var raceWins: Observable<RaceWins> {
        return Observable.create( { observer in
            let races = self.profileData.career
            observer.onNext(RaceWins(terran: races?.terranWins, zerg: races?.zergWins, protoss: races?.protossWins))
            return Disposables.create()
        })
    }
    
    var gamesPlayed: Observable<GamesPlayed> {
        return Observable.create( { observer in
            let games = self.profileData.career
            observer.onNext(GamesPlayed(total: games?.careerTotalGames, season: games?.seasonTotalGames))
            return Disposables.create()
        })
    }
    
    var highestOneVOneRank: Observable<String> {
        return Observable.create( { observer in
            observer.onNext((self.profileData.career?.highest1v1Rank)!)
            return Disposables.create()
        })
    }
    
    init(flowDelegate: SC2ProfileCoordinator) {
        self.flowDelegate = flowDelegate
    }
}
