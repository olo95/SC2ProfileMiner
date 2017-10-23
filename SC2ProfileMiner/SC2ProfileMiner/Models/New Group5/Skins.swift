import Foundation
import ObjectMapper

public class Skins: Mappable {
	public var name : String?
	public var title : String?
	public var id : Int?
	public var icon : Icon?
	public var achievementId : Int?
    
    public func mapping(map: Map) {
        name <- map["name"]
        title <- map["title"]
        id <- map["id"]
        icon <- map["icon"]
        achievementId <- map["achievementId"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
