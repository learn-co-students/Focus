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
    
    @IBOutlet weak var progressBarView: UIView!
    
    @IBOutlet weak var progressBarUpdate: UIProgressView!
    
    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
    
    var progress:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
        
//        createGoal()
        
//        
//        self.progress += progressUpdate(goalAmount: (store.goals.first?.goalAmount)!, saved: (store.goals.first?.currentAmountSaved)!)
//        
//       
//        self.progressBarUpdate.setProgress(progress, animated: true)
//        
//      
//        print("running")
//        
//    }
    
    //add to progress
    
    
    func progressUpdate (goalAmount:Double, saved: Double) -> Float {
        let progress = Float(saved/goalAmount)
        return progress
        
        
    }
    
//    func createGoal () {
//        var newShoes = Goal()
//        newShoes.currentAmountSaved = 4.0
//        newShoes.goalAmount = 100.0
//        store.goals.append(newShoes)
//    }
  
    
    
    
    
    }
}


