//
//  RollerOptions.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import Foundation

public class RollerOptions {
    
    static var roller = CardsRoller()
    static var settings = FilterSettings()
    
    public class func cardsOrDices() -> Bool {
        return FilterSettings.getDicesNumber() == "--"
    }
    
    public class func numberOfRolls() -> NSMutableArray {
        let number = FilterSettings.getCardsCount()
        let array = NSMutableArray()
        
        for _ in 1...number {
            array.add(CardsRoller.rollCards())
        }
        return array
    }
    
    public class func numberOfDices() -> NSMutableArray {
        var number = 6
        if FilterSettings.getDicesNumber() != "--" {
            number = FilterSettings.getCardsCount()
        }
        let array = NSMutableArray()
        
        for _ in 1...number {
            array.add(CardsRoller.rollDices())
        }
        return array
    }
    
    public class func numberOfRolls1(card: String) -> NSMutableArray {
        let number = FilterSettings.getCardsCount()
        let array = NSMutableArray()
        for _ in 1...number {
            array.add(card)
        }
        return array
    }
    
    public class func setTypeOfCards() -> [String : String] {
        let type = FilterSettings.getCardsType()
        var array: [String : String] = [:]
        switch type {
        case .all:
            array = CardsRoller.gameIcons
        case .action:
            array = actionsArray
        case .event:
            array = [:]
        case .monster:
            array = monstersArray
        case .race:
            array = racesArray
        default: break
        }
        return array
    }
    
    public class func setTypeOfDices() -> [Int] {
        let type = FilterSettings.getDicesNumber()
        var array: [Int] = [6]
        switch type {
        case "6":
            array = [1, 2, 3, 4, 5, 6]//dices6Array
        case "10":
            array = [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10]
        case "20":
            array = [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        default: break
        }
        return array
    }
}
