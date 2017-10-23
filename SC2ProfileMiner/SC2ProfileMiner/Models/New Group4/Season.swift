import Foundation
import ObjectMapper

public class Season: Mappable {
	public var seasonId : Int?
	public var seasonNumber : Int?
	public var seasonYear : Int?
	public var totalGamesThisSeason : Int?
	public var stats : Array<Stats>?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        seasonId <- map["seasonId"]
        seasonNumber <- map["seasonNumber"]
        seasonYear <- map["seasonYear"]
        totalGamesThisSeason <- map["totalGamesThisSeason"]
        stats <- map["stats"]
    }
}
