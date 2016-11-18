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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

protocol SaveGoalDelegate {
    func save(goal: Goal)
}

extension GoalViewController: SaveGoalDelegate {
    func save(goal: Goal) {
        store.goals.append(goal)
    }
}
