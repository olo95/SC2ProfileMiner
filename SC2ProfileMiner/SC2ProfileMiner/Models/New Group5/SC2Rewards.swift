import Foundation
import ObjectMapper

public class SC2Rewards: Mappable {
    public var portraits : Array<Portraits>?
    public var terranDecals : Array<TerranDecals>?
    public var zergDecals : Array<ZergDecals>?
    public var protossDecals : Array<ProtossDecals>?
    public var skins : Array<Skins>?
    public var animations : Array<Animations>?
    
    public func mapping(map: Map) {
        portraits <- map["portraits"]
        terranDecals <- map["terranDecals"]
        zergDecals <- map["zergDecals"]
        protossDecals <- map["protossDecals"]
        skins <- map["skins"]
        animations <- map["animations"]
    }
    
    required convenience public init?(map _: Map) {
        self.init()
    }
}
