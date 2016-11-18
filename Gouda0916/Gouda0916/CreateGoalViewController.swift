//
//  CreateGoalViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/16/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {
    var delegate: SaveGoalDelegate?
    
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var goalPurchaseTextField: UITextField!
    @IBOutlet weak var timeframeTextField: UITextField!
    @IBOutlet weak var waysToSaveTextField: UITextField!
    @IBOutlet weak var dailyBudgetTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Tap IBActions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}

//MARK: Text Field Validation
extension CreateGoalViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let validInput = checkForValidInputIn(textField: textField)
        
        if validInput {
            //animate to confirm
            checkIfAllTextFieldsAreValid()
            //Activat button if all are avalid
        } else {
            //animate to deny
        }
    }
    
    func checkForValidInputIn(textField: UITextField) -> Bool {
        var isValid = false
        let userInput = textField.text
        
        switch textField {
        case goalTextField, dailyBudgetTextField:
            if let userInput = userInput {
                let inputAsDouble = Double(userInput)
                if inputAsDouble != nil {
                    isValid = true
                }
            }
        default:
            break
        }
        
        
        return isValid
    }
    
    func checkIfAllTextFieldsAreValid() {
        
    }
}






















