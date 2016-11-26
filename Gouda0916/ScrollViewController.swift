//
//  ScrollViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/26/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var purchaseGoal: CreateGoalStepView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        purchaseGoal.textField.becomeFirstResponder()
        
        
    }
}
