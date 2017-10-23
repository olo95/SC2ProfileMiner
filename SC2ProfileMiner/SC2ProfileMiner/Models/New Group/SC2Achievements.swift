import Foundation
import ObjectMapper

public class SC2Achievements: Mappable {
  public var achievements : Array<Achievements>?
  public var categories : Array<Categories>?
    
    public func mapping(map: Map) {
        achievements <- map["achievements"]
        categories <- map["categories"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
