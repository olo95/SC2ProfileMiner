import Foundation
import ObjectMapper

public class Achievements: Mappable {
	public var title : String?
	public var description : String?
	public var achievementId : Int?
	public var categoryId : Int?
	public var points : Int?
	public var icon : Icon?
    
    public func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        achievementId <- map["achievementId"]
        categoryId <- map["categoryId"]
        points <- map["points"]
        icon <- map["icon"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
