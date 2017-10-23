import Foundation
import ObjectMapper

public class SC2Ladder: Mappable {
  public var ladderMembers : Array<LadderMembers>?
    
    public func mapping(map: Map) {
        ladderMembers <- map["ladderMembers"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
