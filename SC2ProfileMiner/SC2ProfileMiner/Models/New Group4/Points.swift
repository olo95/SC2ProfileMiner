import Foundation
import ObjectMapper

public class Points: Mappable {

	public var totalPoints : Int?
	//public var categoryPoints : CategoryPoints?
    
    required convenience public init?(map _: Map) {
        self.init()
    }
    
    public /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        totalPoints <- map["totalPoints"]
//        categoryPoints <- map["categoryPoints"]
    }
}
