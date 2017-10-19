//
//  CABasicAnimation+Extension.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.10.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

extension CABasicAnimation {
    func pulseAnimation(duration: Double) -> CABasicAnimation {
        keyPath = #keyPath(CALayer.opacity)
        self.duration = duration
        fromValue = 0.25
        toValue = 1
        timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        autoreverses = true
        repeatCount = .greatestFiniteMagnitude
        return self
    }
}
