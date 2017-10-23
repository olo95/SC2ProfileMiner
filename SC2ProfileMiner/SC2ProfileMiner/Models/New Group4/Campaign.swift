import Foundation
import ObjectMapper

public class Campaign: Mappable {
	public var wol : String?
	public var hots : String?
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        wol <- map["wol"]
        hots <- map["hots"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
