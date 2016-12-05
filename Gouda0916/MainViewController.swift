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
import CoreData
import CoreGraphics

//@IBDesignable


class MainViewController: UIViewController {

    
    @IBOutlet weak var addGoalView: UIView!
    
    @IBOutlet weak var addNewGoalView: UIView!
    
    
    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
        calculateProgress()
        addNewGoalView.isHidden = true
        addGoalView.isHidden = true
        //checkIfGoalExists()
        
    }

    
    //UPDATES THE PROGRESS, WHEN DRAW RECT IS CALLED, INPUTS THE CGFLOAT TO THE DASH
    
    func calculateProgress() {
        print("print")
        guard let checkSaved = store.goals.first?.currentAmountSaved else {print ("nothing saved"); return}
        guard let checkGoalAmount = store.goals.first?.currentAmountSaved else {print ("no goal"); return}
        
        var progressPercentage = CGFloat(checkSaved/checkGoalAmount) 
        
        
        store.progress = 812 * progressPercentage
        
    }
    
    
    
    func checkIfGoalExists() {
        if store.goals.isEmpty {
            addGoalView.isHidden = true
            addNewGoalView.isHidden = false
        }
        else{
            //if today's entry is empty,
            addGoalView.isHidden = true
            addNewGoalView.isHidden = true
        }
    }
    
}




