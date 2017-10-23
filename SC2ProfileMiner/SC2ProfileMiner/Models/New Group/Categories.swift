import Foundation
import ObjectMapper

public class Categories: Mappable {
	public var title : String?
	public var categoryId : Int?
	public var featuredAchievementId : Int?
	public var children : Array<Children>?
    
    public func mapping(map: Map) {
        title <- map["title"]
        categoryId <- map["categoryId"]
        featuredAchievementId <- map["featuredAchievementId"]
        children <- map["children"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
