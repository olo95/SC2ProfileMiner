import Foundation
import ObjectMapper

public class NonRanked: Mappable {
	public var mmq : String?
	public var gamesPlayed : Int?
    
    public func mapping(map: Map) {
        mmq <- map["mmq"]
        gamesPlayed <- map["gamesPlayed"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
