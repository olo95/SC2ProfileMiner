//
//  GraphPresenterViewModel.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 26.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import Charts

class GraphPresenterViewModel {
    var flowDelegate: SC2ProfileCoordinator!
    var profileData: SC2Profile!
    var graphType: GraphType!
    var graphData: [(String, Int)] = []
    
    init(flowDelegate: SC2ProfileCoordinator) {
        self.flowDelegate = flowDelegate
    }
    
    func setGraphData(completion: @escaping ([(String, Int)]) -> () ) {
        graphData.removeAll()
        switch graphType {
        case .matchHistory:
            SC2Networker.GET(url: SC2Router.getUrl(parameters: SC2Url(name: profileData.displayName!, id: String(profileData.id!)), method: .matchHistory)) { (result: SC2MatchHistory) in
                result.matches.map( { return $0 }).map( {
                    $0.forEach( { match in
                        self.graphData.append((match.decision!, match.date!))
                        self.graphData = self.graphData.sorted(by: { ($0.1 < $1.1) })
                    })
                })
                completion(self.graphData)
            }
        case .seasonWinsLosses:
            guard let career = profileData.career, let zergWins = career.zergWins, let terranWins = career.terranWins, let protossWins = career.protossWins, let seasonTotalGames = career.seasonTotalGames, let totalGames = career.careerTotalGames else {
                return
            }
            let seasonWins = zergWins + terranWins + protossWins
            let seasonLosses = seasonTotalGames - seasonWins
            graphData.append(("seasonWins", seasonWins))
            graphData.append(("seasonLosses", seasonLosses))
            //graphData.append(("totalGames", totalGames))
            completion(self.graphData)
        default:
            break
        }
    }
}
