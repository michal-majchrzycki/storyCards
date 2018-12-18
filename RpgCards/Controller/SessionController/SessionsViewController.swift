//
//  SessionsViewController.swift
//  RpgCards
//
//  Created by Michal on 06.07.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit

protocol SessionsViewDelegate {
    func set(cards: NSArray)
}

class SessionsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sessionsTableView: UITableView!
    

    var selected: String?
    var delegate: SessionsViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionsTableView.tableFooterView = UIView(frame: CGRect.zero)
        getCards()
    }
    
    func getCards() {
        _ = CardsCache.get()
        sessionsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardsCache.get().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionsTableViewCell", for: indexPath) as! SessionsTableViewCell
        cell.titleLabel?.text = CardsCache.get()[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cards = CardsCache.get()[indexPath.row].ids as! NSArray
        delegate?.set(cards: cards)
        navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            CardsCache.remove(card: CardsCache.get()[indexPath.row])
            self.getCards()
        }
        return [delete]
    }
}
