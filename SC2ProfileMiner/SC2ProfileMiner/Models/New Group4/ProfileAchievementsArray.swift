import Foundation
import ObjectMapper

public class ProfileAchievementsArray: Mappable {
    
    public var achievementId : Int?
    public var completionDate : Int?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        achievementId <- map["achievementId"]
        completionDate <- map["completionDate"]
    }
}
