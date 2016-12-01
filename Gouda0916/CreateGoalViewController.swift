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
    var index = 0
    var screenWidth = UIScreen.main.bounds.width
    weak var goalsTableView: UITableView?
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var whatAreYouSavingFor: UserInputView!
    @IBOutlet weak var howMuchToSave: UserInputView!
    @IBOutlet weak var howManyDays: UserInputView!
    @IBOutlet weak var wayToSave: UserInputView!
    @IBOutlet weak var currentDailyBudget: UserInputView!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var questionOneLeadingConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextForNib()
        addTextFieldsToArray()
        setUpTextFieldsForEditing()
        createButton.isEnabled = false
        createAndAddGestureRecognizers()
        textFields.first?.becomeFirstResponder()
    }
    
    func setTextForNib() {
        whatAreYouSavingFor.label.text = "What are you saving for?"
        howMuchToSave.label.text = "How much do you want to save?"
        howManyDays.label.text = "How many days do you have?"
        wayToSave.label.text = "What can you save money on?"
        currentDailyBudget.label.text = "What is you current daily budget?"
    }
    
    func addTextFieldsToArray() {
        textFields.append(whatAreYouSavingFor.textField)
        textFields.append(howMuchToSave.textField)
        textFields.append(howManyDays.textField)
        textFields.append(wayToSave.textField)
        textFields.append(currentDailyBudget.textField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK: Tap IBActions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        //Force unwrap handled in validation
        let goal = Double(howMuchToSave.textField.text!)!
        let timeframe = Int(howManyDays.textField.text!)!
        let dailyBudget = Double(currentDailyBudget.textField.text!)!
        let goalPurchase = whatAreYouSavingFor.textField.text!
        let waysToSave = [wayToSave.textField.text!]
        
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
        
        goalsTableView?.reloadData()
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
        contentView.addGestureRecognizer(swipeLeft)
        contentView.addGestureRecognizer(swipeRight)
    }
    
    func swipe(sender: UISwipeGestureRecognizer) {
        
        if index < textFields.count {
            if sender.direction == .left {
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    self.questionOneLeadingConstraint.constant -= self.screenWidth * 0.8125
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    self.index += 1
                    if self.index < self.textFields.count {
                        self.textFields[self.index].becomeFirstResponder()
                    }
                })
                
            }
        }
        
        if index > 0 {
            if sender.direction == .right {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    self.questionOneLeadingConstraint.constant += self.screenWidth * 0.8125
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    self.index -= 1
                    self.textFields[self.index].becomeFirstResponder()
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
            textField.textColor = UIColor.themeBlackColor
        } else {
            textField.textColor = .red
        }
        
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
        case howMuchToSave.textField, currentDailyBudget.textField, howManyDays.textField:
            if let userInput = userInput {
                let inputAsDouble = Double(userInput)
                if inputAsDouble != nil {
                    if inputAsDouble! > 0.0 {
                        isValid = true
                    }
                }
            }
        case whatAreYouSavingFor.textField, wayToSave.textField:
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
            if field.textColor != UIColor.themeBlackColor {
                allValid = false
            }
        }
        return allValid
    }
}





















