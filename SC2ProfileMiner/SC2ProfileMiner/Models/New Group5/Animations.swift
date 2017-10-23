import Foundation
import ObjectMapper

public class Animations: Mappable {
	public var title : String?
	public var command : String?
	public var id : Int?
	public var icon : Icon?
	public var achievementId : Int?
    
    public func mapping(map: Map) {
        title <- map["title"]
        command <- map["command"]
        id <- map["id"]
        icon <- map["icon"]
        achievementId <- map["achievementId"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
