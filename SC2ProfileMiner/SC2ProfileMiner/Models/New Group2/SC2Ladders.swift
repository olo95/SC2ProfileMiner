import Foundation
import ObjectMapper

public class SC2Ladders: Mappable {
  public var currentSeason : Array<CurrentSeason>?
  public var previousSeason : Array<PreviousSeason>?
  public var showcasePlacement : Array<ShowcasePlacement>?
    
    public func mapping(map: Map) {
        currentSeason <- map["currentSeason"]
        previousSeason <- map["previousSeason"]
        showcasePlacement <- map["showcasePlacement"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
