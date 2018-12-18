//
//  SettingsViewController.swift
//  RpgCards
//
//  Created by Michal on 14.06.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate {
    func refreshSettings()
}

class SettingsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var settingsTable: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var settingsList = NSMutableDictionary()
    var cardsCount = 4
    var dicesNumber = "--"
    var cardType = CardTypes.all
    var themeType = ThemeTypes.all
    var pickedOption = 0
    var delegate: SettingsViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true
        pickerView.layer.cornerRadius = 10
        pickerView.layer.borderWidth = 2
        loadSettings()
    }
    
    func loadSettings() {
        self.cardsCount = FilterSettings.getCardsCount()
        self.dicesNumber = FilterSettings.getDicesNumber()
        self.cardType = FilterSettings.getCardsType()
        self.themeType = FilterSettings.getThemeType()
        self.settingsTable.reloadData()
    }
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.detailsLabel.layer.borderWidth = 1
        cell.detailsLabel.layer.borderColor = UIColor.black.cgColor
        cell.switchButton.isOn = FilterSettings.getDescription()
        
        if indexPath.row == 0 {
            cell.imageIcon.setIcon(from: .gameIcon, code: "game-icon-card-draw")
            cell.titleLabel.text = "Roll Number:"
            cell.detailsLabel.text = " \(cardsCount) "
        } else if indexPath.row == 1 {
            cell.imageIcon.setIcon(from: .rpgAwesome, code: "ra-var-icon-dice-six")
            cell.titleLabel.text = "Show dices:"
            cell.detailsLabel.text = " \(dicesNumber) "
        } else {
            cell.switchButton.isHidden = false
            cell.imageIcon.setIcon(from: .gameIcon, code: "game-icon-bolt-eye")
            cell.titleLabel.text = "Description:"
            cell.detailsLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 2 {
            pickedOption = indexPath.row
            pickerView.reloadAllComponents()
            pickerView.isHidden = false
            delegate?.refreshSettings()
        } else {
            pickerView.isHidden = true
        }

    }
    
    //MARK: PickerView Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var counter = 0
        switch pickedOption {
        case 0:
            counter = 10
        case 1:
            counter = 4
        default: break
        }
        return counter
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var array = [String]()
        switch pickedOption {
        case 0:
            array = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        case 1:
            array = ["--", "6", "10", "20"]
        default: break
        }
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let number = row + 1
        switch pickedOption {
        case 0:
            FilterSettings.saveCards(count: number)
        case 1:
            var dice = "--"
            if row == 0 {
                dice = "--"
            } else if row == 1 {
                dice = "6"
            } else if row == 2 {
                dice = "10"
            } else if row == 3 {
                dice = "20"
            }
            FilterSettings.saveDices(number: dice)
        case 2: break
        default: break
        }
        loadSettings()
        delegate?.refreshSettings()
        pickerView.isHidden = true
    }
    
    @IBAction func onSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            sender.setOn(false, animated: true)
            FilterSettings.setDescription(isOn: false)
        } else {
            sender.setOn(true, animated: true)
            FilterSettings.setDescription(isOn: true)
        }
    }
    
}
