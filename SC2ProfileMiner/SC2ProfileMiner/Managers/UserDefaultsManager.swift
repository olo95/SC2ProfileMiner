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
        
        let buildCellDataArray = arrayOfData
            .filter { return !$0.isEmpty }
            .map {
                return BuildCellData( (time: String(describing: $0[0]), action: String(describing: $0[1]),
                                       description: String(describing: $0[2])) )
                
            }
        
        return buildCellDataArray
    }
    
    static func saveProfileId(id: Int) {
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: "profileIds")  as? [Int] ?? [Int]()
        if array.contains(id) {
            return
        }
        var range: Range<Int>?
        if array.count == 5 {
            range = array.index(array.endIndex, offsetBy: -5) ..< array.endIndex
        } else {
            range = array.index(array.endIndex, offsetBy: -(array.count % 5)) ..< array.endIndex
        }
        let arraySlice = array[range!]
        var newArray = Array(arraySlice)
        newArray.append(id)
        defaults.set(newArray, forKey: "profileIds")
    }
    
    static func saveProfileName(name: String) {
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey: "profileNames") ?? [String]()
        if array.contains(name) {
            return
        }
        var range: Range<Int>?
        if array.count == 5 {
            range = array.index(array.endIndex, offsetBy: -5) ..< array.endIndex
        } else {
            range = array.index(array.endIndex, offsetBy: -(array.count % 5)) ..< array.endIndex
        }
        let arraySlice = array[range!]
        var newArray = Array(arraySlice)
        newArray.append(name)
        defaults.set(newArray, forKey: "profileNames")
    }
}
