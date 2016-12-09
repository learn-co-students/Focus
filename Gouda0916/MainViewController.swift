//
//  MainViewController2.swift
//  Gouda0916
//
//  Created by Marie Park on 12/5/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import CoreData
import CoreGraphics

//@IBDesignable


class MainViewController: UIViewController {
    
    @IBOutlet weak var gradient: UIView!
    
    @IBOutlet var addNewGoalView: UIView!
    
    @IBOutlet weak var didYouSpendTodayView: UIView!
    
    @IBOutlet weak var footerView: FooterView!
    
    
    @IBAction func goToGoalVC2(_ sender: Any) {
        NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
   
  
    @IBAction func goToGoalVC(_ sender: Any) {
        NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
    
    
    
    
    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
    var menuIsShowing = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        store.fetchData()
        calculateProgress()
        checkIfGoalExists()
      
        
        
        let startingColorOfGradient = UIColor.themePaleGreenColor.cgColor
        let endingColorOFGradient = UIColor.themeLightPrimaryBlueColor.cgColor
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.frame = gradient.bounds
        gradient1.colors = [startingColorOfGradient , endingColorOFGradient]
        self.gradient.layer.insertSublayer(gradient1, at: 0)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //
    
    
    
    //    func didTap(tapGR: UITapGestureRecognizer){
    //        print ("You touched me.")
    //    }
    
    @IBAction func VelocityBtnPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .openVelocityVC, object: nil)
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if !menuIsShowing {
            NotificationCenter.default.post(name: .unhideBar, object: nil)
            menuIsShowing = true
        } else {
            NotificationCenter.default.post(name: .hideBar, object: nil)
            menuIsShowing = false
        }
        
        
    }
    
    @IBAction func GoalBtnPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
    
    //UPDATES THE PROGRESS, WHEN DRAW RECT IS CALLED, INPUTS THE CGFLOAT TO THE DASH
    
    func calculateProgress() {
        print("print")
        guard let checkSaved = store.goals.first?.currentAmountSaved else {print ("nothing saved"); return}
        guard let checkGoalAmount = store.goals.first?.currentAmountSaved else {print ("no goal"); return}
        
        let progressPercentage = (checkSaved/checkGoalAmount)
        
        store.progress = 812.0 * progressPercentage
        
    }
    
    
    func numberOfDaysLeft (startDate: Date, goalEntity: [Goal]) {
        
        let currentDate = Date()
        let timeSinceStartDateInSeconds = currentDate.timeIntervalSince((goalEntity.first?.startDate)! as Date)
        
        let timeSinceStartDateInDays = timeSinceStartDateInSeconds/(24*60*60)
        
        print(timeSinceStartDateInSeconds)
        print(timeSinceStartDateInDays)
        print("🍣🍔🍳")
        
        let daysLeft = (DataStore.sharedInstance.goals.first?.timeframe)! - Double(timeSinceStartDateInDays)
        print(Int(daysLeft))
        print("🐩🏀🍾")
        
        
    }
    
    
    
    
    //    let interval = laterDate.timeIntervalSinceDate(earlierDate)
    
    
    func checkIfGoalExists() {
        if store.goals.isEmpty {
            didYouSpendTodayView.isHidden = true
            addNewGoalView.isHidden = false
            footerView.hamburgerMenuImageView.isHidden = true
            
        }
            
    else  {
            //if today's entry is empty,
            didYouSpendTodayView.isHidden = true
            addNewGoalView.isHidden = true
            footerView.hamburgerMenuImageView.isHidden = false
            
            
        }
    }
    
    /// hamburger on circleview needs to show 
    /// another else? 
    ///new conversion for circle progressPercentage
    // update labels

    
}
