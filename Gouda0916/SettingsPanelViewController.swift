//
//  BackTableVC.swift
//
//
//  Created by Marie Park on 11/27/16.
//  Copyright © 2016 Marie Park. All rights reserved.
//

import Foundation

class SettingsPanelViewController: UITableViewController {
    
    var tableArray = [String]()
    
    override func viewDidLoad() {
        tableArray = ["Main", "Goal", "Velocity"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
}




