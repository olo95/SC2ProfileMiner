import Foundation
import ObjectMapper

public class Zerg: Mappable {
	public var level : Int?
	public var totalLevelXP : Int?
	public var currentLevelXP : Int?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        level <- map["level"]
        totalLevelXP <- map["totalLevelXP"]
        currentLevelXP <- map["currentLevelXP"]
    }
}
