//
//  UserInputProtocol.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/8/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

protocol UserInputProtocol {
    var store: DataStore { get }
    func checkForVelocity(goal: Goal, textField: UITextField) -> Bool
    func incrementDayAndAmount(goal: Goal, textField: UITextField)
    func checkIfComplete(goal: Goal)
}

extension UserInputProtocol {
    
    //returns true if user spent less than allocaed budget that day
    func checkForVelocity(goal: Goal, textField: UITextField) -> Bool {
        var stayedUnderBudget = false
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                if amountSpent <= goal.dailyBudget {
                    stayedUnderBudget = true
                }
            }
        }
        return stayedUnderBudget
    }
    
    //updates goal stats based on user input
    func incrementDayAmount(goal: Goal, textField: UITextField) {
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                goal.currentAmountSaved += amountSpent
                goal.dayCounter += 1
            }
        }
    }
    
    
    //checks if the goal is complete, if it is it removes it and sets a new goal
    func checkStatus(goal: Goal, notify: (Goal, Bool) -> Void) {
        if goal.currentAmountSaved >= goal.goalAmount {
            notify(goal, true)
            store.goals.remove(at: 0)
            if let nextGoal = store.goals.first {
                nextGoal.isActiveGoal = true
            } else {
                print("no queued goals")
            }
        }
    }
    
    
}
