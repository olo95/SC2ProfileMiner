//
//  SC2BuildTableViewCell.swift
//  SC2ProfileMiner
//
//  Created by Alexander Stolar on 07.11.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import RxSwift
import RxCocoa

class SC2BuildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var timeMomentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
