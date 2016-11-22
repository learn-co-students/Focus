//
//  CreateGoalViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/16/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {
    let store = DataStore.sharedInstance
    var textFields: [UITextField] = []
    
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
    }
    
    func addTextFieldsToArray() {
        textFields.append(goalTextField)
        textFields.append(goalPurchaseTextField)
        textFields.append(timeframeTextField)
        textFields.append(waysToSaveTextField)
        textFields.append(dailyBudgetTextField)
    }
    
    //MARK: Tap IBActions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        //save to coreData and datastore
        let goal = Double(goalTextField.text!)! //need to handle force unwrap in validation
        let timeframe = Int(timeframeTextField.text!)! //need to handle force unwrap in validation
        let dailyBudget = Double(dailyBudgetTextField.text!)! //need to handle force unwrap in validaton
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
        self.dismiss(animated: true, completion: nil)
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
        
        //enables create button if all are valid, diables if any are invalid
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
            if field.backgroundColor == .red {
                allValid = false
            }
        }
        return allValid
    }
}





















