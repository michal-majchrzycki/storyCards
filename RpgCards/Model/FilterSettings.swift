//
//  FilterSettings.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import Foundation

public class FilterSettings {
    
    static let settings = UserDefaults()
    static let defaultCardsNumber = 4
    static let defaultCardType = CardTypes.all
    static let defaultThemesNumber = 4
    static let defaultThemeType = ThemeTypes.all
    
    public class func saveCards(count: Int) {
        settings.removeObject(forKey: "cardsCount")
        settings.set(count, forKey: "cardsCount")
    }
    
    public class func getCardsCount() -> Int {
        return settings.object(forKey: "cardsCount") as? Int ?? defaultCardsNumber
    }
    
    public class func saveDices(number: String) {
        settings.removeObject(forKey: "dicesNumber")
        settings.set(number, forKey: "dicesNumber")
    }
    
    public class func getDicesNumber() -> String {
        return settings.object(forKey: "dicesNumber") as? String ?? "--"
    }
    
    public class func saveCards(type: CardTypes) {
        settings.removeObject(forKey: "cardType")
        settings.set(type.rawValue, forKey: "cardType")
    }
    
    public class func getDescription() -> Bool {
        return settings.bool(forKey: "cardDescription")
    }
    
    public class func setDescription(isOn: Bool) {
        settings.removeObject(forKey: "cardDescription")
        settings.set(isOn, forKey: "cardDescription")
    }
    
    public class func getCardsType() -> CardTypes {
        let type = settings.object(forKey: "cardType") as? String ?? defaultCardType.rawValue
        var typeCard = defaultCardType
        
        switch type {
        case "all":
            typeCard = .all
        case "monster":
            typeCard = .monster
        case "event":
            typeCard = .event
        case "race":
            typeCard = .race
        case "action":
            typeCard = .action
        default:
            typeCard = .all
        }
        return typeCard
    }
    
    public class func saveTheme(type: ThemeTypes) {
        settings.removeObject(forKey: "themeType")
        settings.set(type.rawValue, forKey: "themeType")
    }
    
    public class func getThemeType() -> ThemeTypes {
        let type = settings.object(forKey: "themeType") as? String ?? defaultThemeType.rawValue
        var typeTheme = defaultThemeType
        
        switch type {
        case "all":
            typeTheme = .all
        case "fantasy":
            typeTheme = .fantasy
        case "horror":
            typeTheme = .horror
        case "scifi":
            typeTheme = .scifi
        default:
            typeTheme = .all
        }
        return typeTheme
    }
}
