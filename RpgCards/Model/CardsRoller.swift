//
//  CardsRoller.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import Foundation
import SwiftIconFont

public class CardsRoller {
    
    static let gameIcons = SwiftIconFont.gameiconArr
    static let rpgIcons = SwiftIconFont.rpgAwesomeArr
    //let combinedDict = gameIcons.merging(rpgIcons) { $1 } a to dlatego, że rpgIcons czasami rzuca nilem

    public class func rollCardsX() -> String {
        var iconName = String()
        //let combinedDict = gameIcons.merging(rpgIcons) { $1 } a to dlatego, że rpgIcons czasami rzuca nilem
        let numberOne = arc4random_uniform(UInt32(gameIcons.keys.count)) + 1
        for (index, object) in gameIcons.keys.enumerated() {
            if index == numberOne {
                iconName = object
            }
        }
        return iconName
    }
    
    public class func rollCards() -> String {
        let arrayToRoll = RollerOptions.setTypeOfCards()
        var iconName = String()
        let numberOne = arc4random_uniform(UInt32(arrayToRoll.keys.count)) + 1
        for (index, object) in arrayToRoll.keys.enumerated() {
            if index == numberOne {
                iconName = object
            }
        }
        return iconName
    }
    
    public class func rollDices() -> String {
        let arrayToRoll = RollerOptions.setTypeOfDices()
        var iconName = String()
        let numberOne = arc4random_uniform(UInt32(arrayToRoll.count)) + 1
        for (index, object) in arrayToRoll.enumerated() {
            if index == numberOne {
                iconName = "\(object)"
            }
        }
        return iconName
    }
}
