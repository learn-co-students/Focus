//
//  CreateGoalViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/16/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateGoalViewController: UIViewController {
    let store = DataStore.sharedInstance
    let ref =  FIRDatabase.database().reference()
    var textFields: [UITextField] = []
    var screenWidth = UIScreen.main.bounds.width
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var goalPurchaseTextField: UITextField!
    @IBOutlet weak var timeframeTextField: UITextField!
    @IBOutlet weak var waysToSaveTextField: UITextField!
    @IBOutlet weak var dailyBudgetTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        addTextFieldsToArray()
        setUpTextFieldsForEditing()
        createButton.isEnabled = false
        createAndAddGestureRecognizers()
        textFields.first?.becomeFirstResponder()
        
        
    }
    
    func addTextFieldsToArray() {
        textFields.append(goalTextField)
        textFields.append(goalPurchaseTextField)
        textFields.append(timeframeTextField)
        textFields.append(waysToSaveTextField)
        textFields.append(dailyBudgetTextField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK: Tap IBActions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        //Force unweap handled in validation
        let goal = Double(goalTextField.text!)!
        let timeframe = Int(timeframeTextField.text!)!
        let dailyBudget = Double(dailyBudgetTextField.text!)!
        let goalPurchase = goalPurchaseTextField.text!
        let waysToSave = [waysToSaveTextField.text!]
        
        let context = store.persistentContainer.viewContext
        let goalEntity = Goal(context: context)
        goalEntity.goalAmount = goal
        goalEntity.purchasGoal = goalPurchase
        goalEntity.currentAmountSaved = 0.0
        goalEntity.dayCounter = 0.0
        goalEntity.dailyBudget = dailyBudget
        goalEntity.timeframe = Double(timeframe)
        
        for way in waysToSave {
            let wayEntity = WayToSave(context: context)
            wayEntity.way = way
            goalEntity.addToWaysToSave(wayEntity)
        }
        
        store.saveContext()
        store.goals.append(goalEntity)
   
        ref.child("goals").childByAutoId().setValue(goalEntity.serializeGoalIntoDictionary())

        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Swipe Gestures and animation for goal steps
extension CreateGoalViewController {
    
    func createAndAddGestureRecognizers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        stackView.addGestureRecognizer(swipeLeft)
        stackView.addGestureRecognizer(swipeRight)
    }
    
    func swipe(sender: UISwipeGestureRecognizer) {
        let index = Int((stackViewLeadingConstraint.constant * -1) / screenWidth)
        let numOfStackSubViews = stackView.subviews.count
        if index >= 0 && index < numOfStackSubViews - 1 {
            if sender.direction == .left && textFields[index].backgroundColor == .green {
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    self.stackViewLeadingConstraint.constant -= self.screenWidth
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    self.textFields[index + 1].becomeFirstResponder()
                })
            }
        }
        if index > 0 && index <= numOfStackSubViews {
            if sender.direction == .right {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    self.stackViewLeadingConstraint.constant += self.screenWidth
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    self.textFields[index - 1].becomeFirstResponder()
                })
            }
        }
        
    }
    
    
    
}



//MARK: Text Field Validation
extension CreateGoalViewController {
    
    func setUpTextFieldsForEditing() {
        
        for field in textFields {
            field.addTarget(self, action: #selector(checkForTextFieldEdit), for: UIControlEvents.editingChanged)
        }
    }
    
    func checkForTextFieldEdit(_ textField: UITextField) {
        let validInput = checkForValidInputIn(textField: textField)
        
        //changes text field color
        if validInput {
            textField.backgroundColor = .green
        } else {
            textField.backgroundColor = .red
        }
        textField.backgroundColor?.withAlphaComponent(50)
        
        //enables create button if all are valid, disables if any are invalid
        if checkIfAllTextFieldsAreValid() {
            createButton.isEnabled = true
        } else {
            createButton.isEnabled = false
        }
    }
    
    func checkForValidInputIn(textField: UITextField) -> Bool {
        var isValid = false
        let userInput = textField.text
        
        switch textField {
        case goalTextField, dailyBudgetTextField, timeframeTextField:
            if let userInput = userInput {
                let inputAsDouble = Double(userInput)
                if inputAsDouble != nil {
                    isValid = true
                }
            }
        case goalPurchaseTextField, waysToSaveTextField:
            if userInput != "" {
                isValid = true
            }
        default:
            break
        }
        return isValid
    }
    
    func checkIfAllTextFieldsAreValid() -> Bool {
        var allValid = true
        for field in textFields {
            if field.backgroundColor != .green {
                allValid = false
            }
        }
        return allValid
    }
}





















