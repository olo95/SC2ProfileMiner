//
//  CompareResult.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 29.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import Foundation

struct CompareResultAdvantages {
    static let morePrimaryRaceWins = "Much more primary race wins"
    static let moreAchievements = "Much more achievements obtained"
}

struct CompareResult {
    var winner: String
    var winPossibility: Double
    var winnerAdvantages: [String]
}
