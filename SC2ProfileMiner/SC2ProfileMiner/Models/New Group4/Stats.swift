import Foundation
import ObjectMapper

public class Stats: Mappable {
	public var type : String?
	public var wins : Int?
	public var games : Int?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        type <- map["type"]
        wins <- map["wins"]
        games <- map["games"]
    }
}
