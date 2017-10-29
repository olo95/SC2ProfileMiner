//
//  SC2ProfileCompareManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 29.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import Foundation

struct ProfilePointsModifiers {
    static let seasonWinMod = 2.0
    static let seasonLossMod = 0.5
    static let careerTotalMatchesMod = 0.25
    static let seasonPrimaryRaceWin = 2.0
    static let achievementMod = 0.15
    
}

class SC2ProfileCompareManager {
    
    var profileOnePoints = 0.0
    var profileTwoPoints = 0.0
    var winnerProfilePoints = 0.0
    var loserProfilePoints = 0.0
    
    public func getResult(profileOne: SC2Profile, profileTwo: SC2Profile) -> CompareResult {
        guard let careerOne = profileOne.career, let careerTwo = profileTwo.career, let achievsOne = profileOne.achievements, let achievsTwo = profileTwo.achievements else {
            return CompareResult()
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
        let winPossibility = ( winnerProfilePoints / winnerProfilePoints + loserProfilePoints ) * 100
        
        let compareResult = CompareResult(winner: winner, winPossibility: winPossibility)
        return compareResult
    }
    
    private func checkSeasonMatches(careerOne: Career, careerTwo: Career) {
        
    }
    
    private func checkPrimaryRaceLevelAndCurrentXp(raceOne: SC2Profile, raceTwo: SC2Profile) {
        
    }
    
    private func checkTotalMatches(careerOne: Career, careerTwo: Career) {
        profileOnePoints += Double(careerOne.careerTotalGames!) * ProfilePointsModifiers.careerTotalMatchesMod
        profileOnePoints += Double(careerTwo.careerTotalGames!) * ProfilePointsModifiers.careerTotalMatchesMod
    }
    
    private func checkAchievements(achievementsOne: ProfileAchievements, achievementsTwo: ProfileAchievements) {
        profileOnePoints += Double((achievementsOne.achievements?.count)!) * ProfilePointsModifiers.achievementMod
        profileTwoPoints += Double((achievementsTwo.achievements?.count)!) * ProfilePointsModifiers.achievementMod
    }
}
