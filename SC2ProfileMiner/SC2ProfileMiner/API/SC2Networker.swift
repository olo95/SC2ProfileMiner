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
    static func GET<Item: BaseMappable>(url: URLConvertible, completionHandler: @escaping (Item) -> ()) {
        var data: Item?
        HUD.show(.progress)
        Alamofire.request(url).responseJSON { response in
            let json = response.result.value as! [String: AnyObject]
            data = Mapper<Item>().map(JSON: json)
            if let result = data {
                HUD.hide()
                completionHandler(result)
            }
        }
    }
    
    static func getImage(from url: URL, completionHandler: @escaping (UIImage) -> ()) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completionHandler(image)
            }
        }
    }
}
