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
        navigationController?.navigationBar.isHidden = true
        store.fetchData()
        calculateProgress()
        checkIfGoalExists()
        
        
//        
//        let tapGR = UITapGestureRecognizer(target: self, action: "didTap:")
//        
//        self.addNewGoalView.addGestureRecognizer(tapGR)
        //        self.view.addGestureRecognizer(tapGR)
        
    }
//    



//    func didTap(tapGR: UITapGestureRecognizer){
//        print ("You touched me.")
//    }

   @IBAction func VelocityBtnPressed(_ sender: Any) {
         NotificationCenter.default.post(name: .openVelocityVC, object: nil)
    }

      @IBAction func MenuBtnPressed2(_ sender: Any) {
        NotificationCenter.default.post(name: .unhideBar, object: nil)
    }
    
    @IBAction func GoalBtnPressed(_ sender: UIButton) {
         NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
    
    //UPDATES THE PROGRESS, WHEN DRAW RECT IS CALLED, INPUTS THE CGFLOAT TO THE DASH
    
    func calculateProgress() {
        print("print")
        guard let checkSaved = store.goals.first?.currentAmountSaved else {print ("nothing saved"); return}
        
        guard let checkGoalAmount = store.goals.first?.goalAmount else {print ("no goal amount"); return}
        
        store.progress += (812 - CGFloat(checkSaved/checkGoalAmount)/812)
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




