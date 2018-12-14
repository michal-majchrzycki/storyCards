//
//  SettingsTableViewCell.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    var value: String? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        titleLabel.text = value
    }
}
