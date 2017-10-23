import Foundation
import ObjectMapper

public class Career: Mappable {

	public var primaryRace : String?
	public var terranWins : Int?
	public var protossWins : Int?
	public var zergWins : Int?
	public var highest1v1Rank : String?
	public var highestTeamRank : String?
	public var seasonTotalGames : Int?
	public var careerTotalGames : Int?
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        primaryRace <- map["primaryRace"]
        terranWins <- map["terranWins"]
        protossWins <- map["protossWins"]
        zergWins <- map["zergWins"]
        highest1v1Rank <- map["highest1v1Rank"]
        highestTeamRank <- map["highestTeamRank"]
        seasonTotalGames <- map["seasonTotalGames"]
        careerTotalGames <- map["careerTotalGames"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
