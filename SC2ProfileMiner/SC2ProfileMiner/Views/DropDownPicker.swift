//
//  DropDownPicker.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 19.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import UIKit

enum DropDownDataType {
    case ids
    case names
}

class DropDownPicker: UIView {
    var picker = UIPickerView()
    var intArray: [Int]?
    var stringArray: [String]?
    
    init(frame: CGRect, typeOfData: DropDownDataType) {
        super.init(frame: frame)
        picker = UIPickerView(frame: frame)
        
        let defaults = UserDefaults.standard
        switch typeOfData {
        case .names:
            stringArray = defaults.stringArray(forKey: "profileNames") ?? [String]()
        case .ids:
            intArray = defaults.array(forKey: "profileIds")  as? [Int] ?? [Int]()
        }
        picker.delegate = self
        picker.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DropDownPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let stringArray = self.stringArray {
            return stringArray.count
        } else if let intArray = self.intArray {
            return intArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.removeFromSuperview()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let stringArray = self.stringArray {
            return stringArray[row]
        } else if let intArray = self.intArray {
            return String(describing: intArray[row])
        } else {
            return ""
        }
    }
}
