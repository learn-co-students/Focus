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
    
    @IBAction func MenuBtnPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .unhideBar, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goalTableView.reloadData()
    }
//    @IBAction func backButtonTapped(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
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
        cell.goalCellView.goal = store.goals[indexPath.row]
        return cell
    }
}
