import Foundation
import ObjectMapper

public class Matches: Mappable {
	public var map : String?
	public var type : String?
	public var decision : String?
	public var speed : String?
	public var date : Int?
    
    public func mapping(map: Map) {
        self.map <- map["map"]
        type <- map["type"]
        decision <- map["decision"]
        speed <- map["speed"]
        date <- map["date"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
