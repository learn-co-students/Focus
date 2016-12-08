//
//  UserInputProtocol.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/8/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

protocol UserInputProtocol {
    func incrementDayAndAmount(goal: Goal, textField: UITextField) -> Bool
    func checkStatus(goal: Goal)
    func completeGoal(goal: Goal)
}

extension UserInputProtocol {
    
    //updates goal stats based on user input
    func incrementDayAmount(goal: Goal, textField: UITextField) -> Bool {
        var stayedUnderBudget = false
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                if amountSpent <= goal.dailyBudget {
                    stayedUnderBudget = true
                }
                goal.currentAmountSaved += amountSpent
            }
        }
        
        return stayedUnderBudget
    }
    
    //checks if the user saved enough for velocity and if the goal is complete
    func checkStatusAndVelocity(goal: Goal) -> Bool {
      return true
    }
    
    //goal is removed and new goal is made active or user is asked to create a new goal
    func completeGoal(goal: Goal) {
    
    }
    
}
