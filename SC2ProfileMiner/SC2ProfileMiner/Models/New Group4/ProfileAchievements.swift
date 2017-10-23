import Foundation
import ObjectMapper

public class ProfileAchievements: Mappable {

	public var points : Points?
	public var achievements : Array<ProfileAchievements>?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        points <- map["points"]
        achievements <- map["achievements"]
    }
}
