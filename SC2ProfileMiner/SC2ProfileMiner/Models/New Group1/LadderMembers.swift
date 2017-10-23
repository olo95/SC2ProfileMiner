import Foundation
import ObjectMapper

public class LadderMembers: Mappable {
	public var character : Character?
	public var joinTimestamp : Int?
	public var points : Int?
	public var wins : Int?
	public var losses : Int?
	public var highestRank : Int?
	public var previousRank : Int?
	public var favoriteRaceP1 : String?
    
    public func mapping(map: Map) {
        character <- map["character"]
        joinTimestamp <- map["joinTimestamp"]
        points <- map["points"]
        wins <- map["wins"]
        losses <- map["losses"]
        highestRank <- map["highestRank"]
        previousRank <- map["previousRank"]
        favoriteRaceP1 <- map["favoriteRaceP1"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
