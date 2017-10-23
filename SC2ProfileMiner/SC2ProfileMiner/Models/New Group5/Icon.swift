import Foundation
import ObjectMapper

public class Icon: Mappable {
	public var x : Int?
	public var y : Int?
	public var w : Int?
	public var h : Int?
	public var offset : Int?
	public var url : String?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
        w <- map["w"]
        h <- map["h"]
        offset <- map["offset"]
        url <- map["url"]
    }
}
