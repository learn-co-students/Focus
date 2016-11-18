//
//  CreateGoalViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/16/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {
    var delegate: SaveGoalDelegate?
    
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var goalPurchaseTextField: UITextField!
    @IBOutlet weak var timeframeTextField: UITextField!
    @IBOutlet weak var dailyBudgetTextField: UITextField!
    @IBOutlet weak var waysToSaveTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


