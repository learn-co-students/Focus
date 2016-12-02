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


class MainViewController: UIViewController {
    
    
    
    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
    //    var goalsHere = DataStore.sharedInstance.goals.first?.goalAmount
    //    var savedHere = DataStore.sharedInstance.goals.first?.currentAmountSaved
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
        
//        let tapGR = UITapGestureRecognizer(target: self, action: "didTap")
//        self.view.addGestureRecognizer(tapGR)
        
        
        
        //        store.progress += progressUpdate(goalAmount: goalsHere, saved: savedHere)
        
        
    }
    
//    func didTap(tapGR: UITapGestureRecognizer) {
//        
//        let shapeView = TreatYourselfLandingView(frame: tapPoint)
//        self.view.addSubview(shapeView)
//        
//    }
    
    //  add to progress
    
//    
//    func progressUpdate (goalAmount:Double, saved: Double) -> Float {
//        
//        print("print")
//        let progress = Float(saved/goalAmount)
//        return progress
//    }
//    
//    func submit() {
//        guard let unwrappedGoal = store.goals.first?.goalAmount else {
//            print("no goals")
//            return
//        }
//        guard let unwrappedSaved = store.goals.first?.currentAmountSaved else {
//            print("no amount saved")
//            return
//        }
//        
//        store.progress += progressUpdate(goalAmount: unwrappedGoal, saved: unwrappedSaved)
    
//                store.progress += progressUpdate(goalAmount: (store.goals.first?.goalAmount)!, saved: ((store.goals.first?.currentAmountSaved)))
        
//    }
    
    //

    
    func createGoal () {
        var newShoes = Goal()
        newShoes.currentAmountSaved = 4.0
        newShoes.goalAmount = 100.0
        store.goals.append(newShoes)
    }
    
    

}






