//
//  CreateGoalViewConroller.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class GoalViewController: UIViewController {
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var goalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goalTableView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as! CustomGoalCell
        let goal = store.goals[indexPath.row]
        cell.titleLabel.text = (goal.purchasGoal?.capitalized)
        cell.savingsProgressLabel.text = "Saving Progress: \(goal.currentAmountSaved)"
        cell.daysProgressLabel.text = "Days Progress: \(goal.dayCounter)/\(goal.timeframe)"
        cell.dailyAllowanceLabel.text = "Daily Allowance: \(Int(goal.alloctedDailyBudget!))"
        return cell
    }
    
}
