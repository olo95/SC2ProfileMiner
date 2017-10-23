import Foundation
import ObjectMapper

public class SwarmLevels {
	public var level : Int?
	public var terran : Terran?
	public var zerg : Zerg?
	public var protoss : Protoss?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        level <- map["level"]
        terran <- map["terran"]
        zerg <- map["zerg"]
        protoss <- map["protoss"]
    }
}
