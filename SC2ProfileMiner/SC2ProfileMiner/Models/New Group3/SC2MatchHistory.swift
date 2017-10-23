import Foundation
import ObjectMapper

public class SC2MatchHistory: Mappable {
    public var matches : Array<Matches>?
    
    public func mapping(map: Map) {
        matches <- map["matches"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
