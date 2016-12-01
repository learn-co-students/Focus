//
//  MainViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class MainViewController: UIViewController {
    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
    
    @IBAction func MenuBtnPressed2(_ sender: Any) {
        NotificationCenter.default.post(name: .unhideBar, object: nil)
    }
    
    @IBAction func GoalBtnPressed(_ sender: UIButton) {
         NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
    
    @IBAction func VelocityBtnPressed(_ sender: Any) {
         NotificationCenter.default.post(name: .openVelocityVC, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}


