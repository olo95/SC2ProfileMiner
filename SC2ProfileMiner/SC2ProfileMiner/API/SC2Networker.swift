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
    static func GET<Item: BaseMappable>(url: URLConvertible, completion: @escaping (Item?) -> ()) {
        var data: Item?
        HUD.show(.progress)
        Alamofire.request(url).responseJSON { response in
            print(response.result.value)
            switch response.response?.statusCode {
            case 200?:
                let json = response.result.value as! [String: AnyObject]
                data = Mapper<Item>().map(JSON: json)
                completion(data)
                HUD.hide()
            case 404?:
                HUD.flash(.labeledError(title: "Error", subtitle: "Profile not found"), delay: 1.0)
                completion(nil)
                return
            default:
                HUD.flash(.labeledError(title: "Error", subtitle: "Something went wrong"), delay: 1.0)
                completion(nil)
                return
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
