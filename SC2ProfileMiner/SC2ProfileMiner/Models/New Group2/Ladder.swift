import Foundation
import ObjectMapper

public class Ladder: Mappable {
	public var ladderName : String?
	public var ladderId : Int?
	public var division : Int?
	public var rank : Int?
	public var league : String?
	public var matchMakingQueue : String?
	public var wins : Int?
	public var losses : Int?
	public var showcase : String?
    
    public func mapping(map: Map) {
        ladderName <- map["ladderName"]
        ladderId <- map["ladderId"]
        division <- map["division"]
        rank <- map["rank"]
        league <- map["league"]
        matchMakingQueue <- map["matchMakingQueue"]
        wins <- map["wins"]
        losses <- map["losses"]
        showcase <- map["showcase"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
