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
import UserNotifications


class CreateGoalViewController: UIViewController {
  
    //test notification variables
    let oneMin = TimeInterval.init(60)
    var date = Date()
    let delegate = UIApplication.shared.delegate as? AppDelegate
    

    let store = DataStore.sharedInstance
    let ref =  FIRDatabase.database().reference()
    var textFields: [UITextField] = []
    var index = 0
    var screenWidth = UIScreen.main.bounds.width
    weak var goalsTableView: UITableView?
    
    @IBOutlet weak var finishButton: UIButton!
    
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
        finishButton.isEnabled = false
        createAndAddGestureRecognizers()
        textFields.first?.becomeFirstResponder()
        addActionToButtons()
        finishButton.setTitleColor(UIColor.themeLightGrayColor, for: UIControlState.disabled)

    }
    
    func setTextForNib() {
        whatAreYouSavingFor.label.text = "What are you saving for?"
        howMuchToSave.label.text = "How much do you want to save?"
        howManyDays.label.text = "How many days do you have?"
        wayToSave.label.text = "What can you save money on?"
        currentDailyBudget.label.text = "What is you current daily budget?"
    }
    
    func addActionToButtons() {
        whatAreYouSavingFor.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        howMuchToSave.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        howManyDays.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        wayToSave.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        currentDailyBudget.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
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
    func xButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        //Force unwrap handled in validation
        let goal = Double(howMuchToSave.textField.text!)!
        let timeframe = Int(howManyDays.textField.text!)!
        let dailyBudget = Double(currentDailyBudget.textField.text!)!
        let goalPurchase = whatAreYouSavingFor.textField.text!
        let enteredWayToSave = wayToSave.textField.text!
        
        let context = store.persistentContainer.viewContext
        let goalEntity = Goal(context: context)
        goalEntity.goalAmount = goal
        goalEntity.purchasGoal = goalPurchase
        goalEntity.currentAmountSaved = 0.0
        goalEntity.dayCounter = 0.0
        goalEntity.dailyBudget = dailyBudget
        goalEntity.timeframe = Double(timeframe)
        goalEntity.wayToSave = enteredWayToSave
        createStartAndEnd(timeFrame: timeframe, goalEntity: goalEntity)
        
        if store.goals.isEmpty {
            goalEntity.isActiveGoal = true
        }
        
        date = Date.init(timeIntervalSinceNow: oneMin)
        delegate?.scheduleNotification(at: date)

        store.saveContext()
        store.goals.append(goalEntity)
   
      let refer = ref.child("goals").childByAutoId()
        goalEntity.firebaseID = refer.key
        refer.setValue(goalEntity.serializeGoalIntoDictionary())
      
        goalsTableView?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    

    func createStartAndEnd(timeFrame: Int, goalEntity: Goal) {
        let now = Date()
        let timeInt = TimeInterval(exactly: Double(timeFrame)*60*60*24)
        goalEntity.startDate = now as NSDate?
        let endDate = now.addingTimeInterval(timeInt!)
        goalEntity.endDate = endDate as NSDate?
        
    }

    
    
}

//MARK: Swipe Gestures and animation for goal steps
extension CreateGoalViewController: UITextFieldDelegate {
    
    func createAndAddGestureRecognizers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        contentView.addGestureRecognizer(swipeLeft)
        contentView.addGestureRecognizer(swipeRight)
    }
    
    func swipe(sender: UISwipeGestureRecognizer) {
        
        if index < textFields.count - 1 {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dublicated code
        if index < textFields.count - 1 && textField.textColor != .red {
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
        return true
    }
}



//MARK: Text Field Validation
extension CreateGoalViewController {
    
    func setUpTextFieldsForEditing() {
        
        for field in textFields {
            field.addTarget(self, action: #selector(checkForTextFieldEdit), for: UIControlEvents.editingChanged)
            field.delegate = self
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
            finishButton.isEnabled = true
            
        } else {
            finishButton.isEnabled = false
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





















