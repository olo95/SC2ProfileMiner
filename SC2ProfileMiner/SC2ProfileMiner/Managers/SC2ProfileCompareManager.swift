//
//  SC2ProfileCompareManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 29.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import Foundation

struct ProfilePointsModifiers {
    static let seasonWinMod = 1.5
    static let seasonLossMod = 0.5
    static let careerTotalMatchesMod = 0.1
    static let seasonPrimaryRaceWin = 3.0
    static let achievementMod = 0.1
    static let xpLevel = 0.01
}

struct RacesStrings {
    static let zerg = "ZERG"
    static let protoss = "PROTOSS"
    static let terran = "TERRAN"
}

enum Race {
    case zerg
    case terran
    case protoss
    
    var toString: String {
        switch self {
        case .zerg:
            return RacesStrings.zerg
        case .protoss:
            return RacesStrings.protoss
        case .terran:
            return RacesStrings.terran
        }
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case RacesStrings.zerg:
            self = .zerg
        case RacesStrings.protoss:
            self = .protoss
        case RacesStrings.terran:
            self = .terran
        default:
            return nil
        }
    }
}

class SC2ProfileCompareManager {
    
    var profileOnePoints = 0.0
    var profileTwoPoints = 0.0
    var winnerProfilePoints = 0.0
    var loserProfilePoints = 0.0
    
    var winnerAdvantages: [String] = []
    
    public func getResult(profileOne: SC2Profile, profileTwo: SC2Profile) -> CompareResult {
        guard let careerOne = profileOne.career, let careerTwo = profileTwo.career, let achievsOne = profileOne.achievements, let achievsTwo = profileTwo.achievements else {
            return CompareResult(winner: "", winPossibility: 0.0, winnerAdvantages: winnerAdvantages)
        }
        checkSeasonMatches(careerOne: careerOne, careerTwo: careerTwo)
        checkPrimaryRaceLevelAndCurrentXp(raceOne: profileOne, raceTwo: profileTwo)
        checkTotalMatches(careerOne: careerOne, careerTwo: careerTwo)
        checkAchievements(achievementsOne: achievsOne, achievementsTwo: achievsTwo)
        
        let winner = profileOnePoints > profileTwoPoints ? profileOne.displayName : profileTwo.displayName
        if profileOnePoints > profileTwoPoints {
            winnerProfilePoints = profileOnePoints
            loserProfilePoints = profileTwoPoints
        } else {
            winnerProfilePoints = profileTwoPoints
            loserProfilePoints = profileOnePoints
        }
        let winPossibility = ( winnerProfilePoints / (winnerProfilePoints + loserProfilePoints) ) * 100
        
        let compareResult = CompareResult(winner: winner!, winPossibility: winPossibility, winnerAdvantages: winnerAdvantages)
        return compareResult
    }
    
    private func checkSeasonMatches(careerOne: Career, careerTwo: Career) {
        guard let primaryRaceOneString = careerOne.primaryRace, let primaryRaceTwoString = careerTwo.primaryRace else {
            return
        }
        
        let racesWinsOne = [(Race.zerg, careerOne.zergWins!), (Race.protoss, careerOne.protossWins!), (Race.terran, careerOne.terranWins!)]
        let racesWinsTwo = [(Race.zerg, careerTwo.zergWins!), (Race.protoss, careerTwo.protossWins!), (Race.terran, careerTwo.terranWins!)]
        
        profileOnePoints += racesWinsOne.map( {
            return Double($0.1) * ($0.0.toString == primaryRaceOneString ? ProfilePointsModifiers.seasonPrimaryRaceWin : ProfilePointsModifiers.seasonWinMod)
        }).reduce(0, { return $0 + $1 })
        
        profileTwoPoints += racesWinsTwo.map( {
            return Double($0.1) * ($0.0.toString == primaryRaceTwoString ? ProfilePointsModifiers.seasonPrimaryRaceWin : ProfilePointsModifiers.seasonWinMod)
        }).reduce(0, { return $0 + $1 })
    }
    
    private func checkPrimaryRaceLevelAndCurrentXp(raceOne: SC2Profile, raceTwo: SC2Profile) {
        profileOnePoints += Double(raceOne.swarmLevels?.protoss?.currentLevelXP ?? 0) * ProfilePointsModifiers.xpLevel
        profileOnePoints += Double(raceOne.swarmLevels?.protoss?.currentLevelXP ?? 0) * ProfilePointsModifiers.xpLevel
        profileOnePoints += Double(raceOne.swarmLevels?.protoss?.currentLevelXP ?? 0) * ProfilePointsModifiers.xpLevel
        
        profileTwoPoints += Double(raceTwo.swarmLevels?.protoss?.currentLevelXP ?? 0) * ProfilePointsModifiers.xpLevel
        profileTwoPoints += Double(raceTwo.swarmLevels?.protoss?.currentLevelXP ?? 0) * ProfilePointsModifiers.xpLevel
        profileTwoPoints += Double(raceTwo.swarmLevels?.protoss?.currentLevelXP ?? 0) * ProfilePointsModifiers.xpLevel
    }
    
    private func checkTotalMatches(careerOne: Career, careerTwo: Career) {
        profileOnePoints += Double(careerOne.careerTotalGames!) * ProfilePointsModifiers.careerTotalMatchesMod
        profileTwoPoints += Double(careerTwo.careerTotalGames!) * ProfilePointsModifiers.careerTotalMatchesMod
    }
    
    private func checkAchievements(achievementsOne: ProfileAchievements, achievementsTwo: ProfileAchievements) {
        profileOnePoints += Double((achievementsOne.achievements?.count)!) * ProfilePointsModifiers.achievementMod
        profileTwoPoints += Double((achievementsTwo.achievements?.count)!) * ProfilePointsModifiers.achievementMod
    }
}
