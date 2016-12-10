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


class MainViewController: UIViewController {
    
    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"
    var menuIsShowing = false
    
    @IBOutlet weak var addGoalImageView: UIImageView!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet var addNewGoalView: UIView!
    @IBOutlet weak var didYouSpendTodayView: UIView!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    @IBOutlet weak var daysPercentLabel: UILabel!
    @IBOutlet weak var velocityPercentLabel: UILabel!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var blackOverlayView: UIView!
    @IBOutlet weak var logDayButton: UIButton!
    
    @IBOutlet weak var didYouSubmitTrailingConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setGradient()
        calculateProgress()
        daysPercentCalculation()
        checkIfGoalExists()
        setUpMenuButtonGesture()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(goToGoalVC))
        addGoalImageView.addGestureRecognizer(tapGR)

    }
    
    @IBAction func goToGoalVC(_ sender: UIButton) {
        print("TEST TEST TEST")
        NotificationCenter.default.post(name: .openGoalVC, object: nil)
    }
    
    @IBAction func logDayButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.didYouSubmitTrailingConstraint.constant = UIScreen.main.bounds.width
        }, completion: { success in
            self.userInputTextField.becomeFirstResponder()
        })
    }
    
    func menuButtonPressed(_ sender: Any) {
        if !menuIsShowing {
            NotificationCenter.default.post(name: .unhideBar, object: nil)
            menuIsShowing = true
            UIView.animate(withDuration: 0.3) {
                self.blackOverlayView.alpha = 0.8
                self.view.layoutIfNeeded()
            }
        } else {
            NotificationCenter.default.post(name: .hideBar, object: nil)
            menuIsShowing = false
            UIView.animate(withDuration: 0.3) {
                self.blackOverlayView.alpha = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    //UPDATES THE PROGRESS, WHEN DRAW RECT IS CALLED, INPUTS THE CGFLOAT TO THE DASH
    func calculateProgress() {
        print("print")
        guard let checkSaved = store.goals.first?.currentAmountSaved else {print ("nothing saved"); return}
        guard let checkGoalAmount = store.goals.first?.goalAmount else {print ("no goal"); return}
        let progressPercentage = (checkSaved/checkGoalAmount)
        store.progress = 812.0 * progressPercentage
        progressPercentLabel.text = "\(Int(progressPercentage * 100))%"
    }
    
    func numberOfDaysLeft (startDate: Date, goalEntity: [Goal]) -> Int {
        let currentDate = Date()
        let timeSinceStartDateInSeconds = currentDate.timeIntervalSince((goalEntity.first?.startDate)! as Date)
        let timeSinceStartDateInDays = timeSinceStartDateInSeconds/(24*60*60)
        let daysLeft = (DataStore.sharedInstance.goals.first?.timeframe)! - Double(timeSinceStartDateInDays)
        print(Int(daysLeft))
        return Int(daysLeft)
    }
    
    func daysPercentCalculation() {
        if let first = store.goals.first {
            let dayPercentage = first.dayCounter/first.timeframe
            store.days = CGFloat(dayPercentage * 312.0)
            daysPercentLabel.text = "\(Int(dayPercentage * 100))%"
        }
    }
    
    func checkIfGoalExists() {
        if store.goals.isEmpty {
            logDayButton.isHidden = true
            addNewGoalView.isHidden = false
            footerView.hamburgerMenuImageView.isHidden = true
            
        } else {
            //if today's entry is empty,
            addNewGoalView.isHidden = true
            footerView.hamburgerMenuImageView.isHidden = false
            logDayButton.isHidden = false
        }
    }
    
    func setUpMenuButtonGesture() {
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(menuButtonPressed))
        footerView.hamburgerMenuImageView.addGestureRecognizer(tapGR)
    }
    
    func setGradient() {
        let startingColorOfGradient = UIColor.themePaleGreenColor.cgColor
        let endingColorOFGradient = UIColor.themeLightPrimaryBlueColor.cgColor
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.frame = gradient.bounds
        gradient1.colors = [startingColorOfGradient , endingColorOFGradient]
        self.gradient.layer.insertSublayer(gradient1, at: 0)
    }
}

//MARK: Handling user input
extension MainViewController: UserInputProtocol {
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        //sender.textField
        let _ = checkForVelocity(goal: store.goals.first!, textField: userInputTextField)
        incrementDayAndAmount(goal: store.goals.first!, textField: userInputTextField)
        checkIfComplete(goal: store.goals.first!) { (success) in
            if success {
                print("⚡️YAYYYY YOU DID IT!!!!")
            } else {
                print("🐹YOU DIDNT REACH YOUR GOAL YET")
            }
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.didYouSubmitTrailingConstraint.constant = 0
        }, completion: { success in
            self.userInputTextField.resignFirstResponder()
        })
        
    }
}
