//
//  ColorTheme.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

class ColorTheme: NSObject {
    
    static let appTheme: ColorTheme = {
        let theme = ColorTheme()
        theme.base = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        theme.lightBase = #colorLiteral(red: 0, green: 0.4922660331, blue: 0.8703600888, alpha: 1)
        theme.gray = #colorLiteral(red: 0.7216291482, green: 0.7216291482, blue: 0.7216291482, alpha: 1)
        theme.lightGray = #colorLiteral(red: 0.8890823525, green: 0.8890823525, blue: 0.8890823525, alpha: 1)
        theme.button =  #colorLiteral(red: 0.01847153536, green: 0.6351398216, blue: 0.9745796319, alpha: 1)
        theme.lightButton =  #colorLiteral(red: 0, green: 0.775071112, blue: 1, alpha: 1)
        
        return theme
    }()
    
    private(set) var base: UIColor!
    private(set) var lightBase: UIColor!
    private(set) var gray: UIColor!
    private(set) var lightGray: UIColor!
    private(set) var button: UIColor!
    private(set) var lightButton: UIColor!
    
    private override init() {}
}
