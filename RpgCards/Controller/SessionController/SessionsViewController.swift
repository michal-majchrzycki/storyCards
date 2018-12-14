//
//  SessionsViewController.swift
//  RpgCards
//
//  Created by Michal on 06.07.2018.
//  Copyright © 2018 Prograils.com. All rights reserved.
//

import UIKit

class SessionsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath)
        return cell
    }

}
