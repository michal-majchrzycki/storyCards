//
//  CardsCache.swift
//  RpgCards
//
//  Created by Michal Majchrzycki on 10.08.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit
import CoreData

public class CardsCache {
    static let cache = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let card = Card(context: cache)
    static var cards: [Card] = []
    
    class func save(title: String, array: [String]) {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        do {
            card.name = title
            card.ids = array as NSObject
            try cache.save()
        } catch { }
    }
    
    class func remove(card: Card) {
        cache.delete(card)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        do {
            cards = try cache.fetch(Card.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    class func get() -> [Card] {

        do {
            cards = try cache.fetch(Card.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        return cards
    }
}
