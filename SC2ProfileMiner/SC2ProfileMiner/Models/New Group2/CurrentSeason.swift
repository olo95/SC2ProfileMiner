import Foundation
import ObjectMapper

public class CurrentSeason {
	public var ladder : Array<Ladder>?
	public var characters : Array<Characters>?
	public var nonRanked : Array<String>?
    
    public func mapping(map: Map) {
        ladder <- map["ladder"]
        characters <- map["characters"]
        nonRanked <- map["nonRanked"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
