import Foundation
import ObjectMapper

public class SC2Profile: Mappable {

    public var id : Int?
    public var realm : Int?
    public var displayName : String?
    public var clanName : String?
    public var clanTag : String?
    public var profilePath : String?
    public var career : Career?
    public var swarmLevels : SwarmLevels?
    public var campaign : Campaign?
    public var season : Season?
    public var rewards : Rewards?
    public var achievements : ProfileAchievements?
    
    public func mapping(map: Map) {
        id <- map["id"]
        realm <- map["realm"]
        displayName <- map["displayName"]
        clanName <- map["clanName"]
        clanTag <- map["clanTag"]
        profilePath <- map["profilePath"]
        career <- map["career"]
        swarmLevels <- map["swarmLevels"]
        campaign <- map["campaign"]
        season <- map["season"]
        rewards <- map["rewards"]
        achievements <- map["achievements"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
