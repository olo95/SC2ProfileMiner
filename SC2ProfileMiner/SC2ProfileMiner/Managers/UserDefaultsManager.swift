//
//  UserDefaultsManager.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 14.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    static func saveBuild(with data: [BuildCellData], name: String) {
        var save: [String] = []
        
        save = data.map { return "\($0.time) \($0.action) \($0.description)" }
        
        let defaults = UserDefaults.standard
        defaults.set(save, forKey: name)
        defaults.synchronize()
        print(defaults.stringArray(forKey: name) ?? [String]())
    }
    
    static func loadBuild(name: String) -> [BuildCellData] {
        let defaults = UserDefaults.standard
        let save = defaults.stringArray(forKey: name) ?? [String]()
        
        let arrayOfData = save.map { return $0.split(separator: " ") }
        
        let buildCellDataArray = arrayOfData.filter { return !$0.isEmpty }.map { return BuildCellData( (time: String(describing: $0[0]), action: String(describing: $0[1]), description: String(describing: $0[2])) ) }
        
        return buildCellDataArray
        
//        return save.split(separator: " ").map { return BuildCellData((time: $0[0], action: $0[1], description: $0[2])) }
    }
}
