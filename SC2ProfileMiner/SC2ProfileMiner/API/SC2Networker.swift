//
//  SC2Networker.swift
//  SC2SimpleNetworking
//
//  Created by Alexander Stolar on 30.07.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper
import PKHUD

class SC2Networker {
    static func GET<Item: BaseMappable>(url: URLConvertible, completion: @escaping (Item) -> ()) {
        var data: Item?
        HUD.show(.progress)
        Alamofire.request(url).responseJSON { response in
            let json = response.result.value as! [String: AnyObject]
            data = Mapper<Item>().map(JSON: json)
            if let result = data {
                HUD.hide()
                completion(result)
            }
        }
    }
    
    static func getImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
}
