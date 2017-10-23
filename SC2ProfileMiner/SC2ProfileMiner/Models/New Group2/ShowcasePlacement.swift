import Foundation
import ObjectMapper

public class ShowcasePlacement: Mappable {
	public var ladder : Array<String>?
	public var characters : Array<Characters>?
	public var nonRanked : Array<NonRanked>?
    
    public func mapping(map: Map) {
        ladder <- map["ladder"]
        characters <- map["characters"]
        nonRanked <- map["nonRanked"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
