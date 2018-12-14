//
//  CardCollectionViewCell.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit
import SwiftIconFont

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconLabel: UILabel!
    
    var image: String? {
        didSet {
            setupView()
        }
    }
    
    var dice: String? {
        didSet {
            setupView()
        }
    }
    
    var type = CardTypes.all
    
    func setupView() {
        backView.layer.cornerRadius = 10
        iconImage.layer.cornerRadius = 10
        iconImage.layer.borderWidth = 3
        iconImage.setIcon(from: .gameIcon, code: image ?? "")
        iconLabel.text = dice

    }
}
