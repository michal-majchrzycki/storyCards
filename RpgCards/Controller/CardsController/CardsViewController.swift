//
//  CardsViewController.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit

class CardsViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, SessionsViewDelegate, SettingsViewDelegate {
    
    @IBOutlet weak var cardsCollection: UICollectionView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var cardScaleView: UIView!
    @IBOutlet weak var cardScaleLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardScaleBack: UIView!
    @IBOutlet weak var savedCardsIcon: UIBarButtonItem!
    
    var cardsArray: NSMutableArray = []
    var type = CardTypes.all
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    var cardsSetName: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.layer.cornerRadius = 5
        actionButton.layer.borderWidth = 2
        cardsCollection.addSubview(self.refreshControl)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideCardsScaleView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        rollCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if CardsCache.get().count == 0 {
            savedCardsIcon.isEnabled = false
        } else {
            savedCardsIcon.isEnabled = true
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        rollCards()
        refreshControl.endRefreshing()
    }
    
    private func rollCards() {
        self.cardsArray = RollerOptions.numberOfRolls()
        if CardsCache.get().count == 0 {
            savedCardsIcon.isEnabled = false
        } else {
            savedCardsIcon.isEnabled = true
        }
        cardsCollection.reloadData()
    }
    
    @IBAction func refreshCardsAction(_ sender: UIButton) {
        rollCards()
    }
    
    @IBAction func onAddNewAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Name your deck", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Type name"
        }
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            if let name = alert.textFields?.first?.text {
                self.cardsSetName = name
                self.saveCards()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func onOpenSessionsLins(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSessionsList", sender: sender)
    }
    
    @IBAction func onOpenSettingsViewController(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettingsViewController", sender: sender)
    }
    
    
    @objc func saveCards() {
        if let name = cardsSetName {
            CardsCache.save(title: name, array: cardsArray as! [String])
            savedCardsIcon.isEnabled = true
        }
    }
    
    @objc private func showCardScaleView(icon: String) {
        cardScaleView.isHidden = false
        cardScaleBack.isHidden = false
        cardScaleView.layer.borderWidth = 10
        cardScaleView.backgroundColor = .white
        cardScaleView.layer.borderColor = UIColor.black.cgColor
        cardImage.setIcon(from: .gameIcon, code: icon)
        cardScaleLabel.isHidden = !FilterSettings.getDescription()
        let string = icon.replacingOccurrences(of: "game-icon-", with: "").replacingOccurrences(of: "-", with: " ")
        cardScaleLabel.text = String(string.prefix(1)).uppercased() + String(string.dropFirst())
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.cardScaleView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.cardScaleView.transform = CGAffineTransform.identity
                        }
        })
    }
    
    @objc private func hideCardsScaleView() {
        cardScaleView.isHidden = true
        cardScaleBack.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSessionsList" {
            if let vc = segue.destination as? SessionsViewController {
                vc.delegate = self
            }
        } else if segue.identifier == "showSettingsViewController" {
            if let vc = segue.destination as? SettingsViewController {
                vc.delegate = self
            }
        }
    }
    
    //MARK: CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        if RollerOptions.cardsOrDices() {
            cell.image = self.cardsArray[indexPath.row] as? String
            cell.iconImage.isHidden = false
            cell.iconLabel.isHidden = true
        } else {
            cell.iconLabel.isHidden = false
            cell.iconImage.isHidden = true
            cell.dice = self.cardsArray[indexPath.row] as? String
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if RollerOptions.cardsOrDices() {
            if let code = self.cardsArray[indexPath.row] as? String {
                showCardScaleView(icon: code)
            }
        }
    }
    
    //MARK: SessionsViewDelegate
    
    func set(cards: NSArray) {
        cardsArray = NSMutableArray(array: cards)
        cardsCollection.reloadData()
    }
    
    //MARK: SettingsViewDelegate
    func refreshSettings() {
        rollCards()
    }
}
