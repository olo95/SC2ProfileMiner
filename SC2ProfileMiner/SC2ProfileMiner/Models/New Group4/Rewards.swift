import Foundation
import ObjectMapper

public class Rewards: Mappable {
	public var selected : Array<Int>?
	public var earned : Array<Int>?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        selected <- map["selected"]
        earned <- map["earned"]
    }
}
