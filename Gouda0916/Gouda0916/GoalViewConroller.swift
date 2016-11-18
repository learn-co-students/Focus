//
//  CreateGoalViewConroller.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController {
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var goalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goalVCToCreateGoalVC" {
            let destVC = segue.destination as! CreateGoalViewController
            destVC.delegate = self
        }
    }
}


//MARK: Save Goal Protocol
protocol SaveGoalDelegate {
    func save(goal: Goal)
}

extension GoalViewController: SaveGoalDelegate {
    func save(goal: Goal) {
        store.goals.append(goal)
        goalTableView.reloadData()
    }
}


//MARK: Table View Delegate and Datasource
extension GoalViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell")
        cell?.textLabel?.text = store.goals[indexPath.row].goalPurchase
        return cell!
    }
    
}
