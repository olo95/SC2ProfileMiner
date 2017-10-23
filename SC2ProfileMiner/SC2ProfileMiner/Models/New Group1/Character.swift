import Foundation
import ObjectMapper

public class Character: Mappable {
	public var id : Int?
	public var realm : Int?
	public var displayName : String?
	public var clanName : String?
	public var clanTag : String?
	public var profilePath : String?
    
    public func mapping(map: Map) {
        id <- map["id"]
        realm <- map["realm"]
        displayName <- map["displayName"]
        clanName <- map["clanName"]
        clanTag <- map["clanTag"]
        profilePath <- map["profilePath"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
