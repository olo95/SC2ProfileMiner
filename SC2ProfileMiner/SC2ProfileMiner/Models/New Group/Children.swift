import Foundation
import ObjectMapper

public class Children: Mappable {
	public var title : String?
	public var categoryId : Int?
	public var featuredAchievementId : Int?
    
    public func mapping(map: Map) {
        title <- map["title"]
        categoryId <- map["categoryId"]
        featuredAchievementId <- map["featuredAchievementId"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
