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

}

extension UserInputProtocol {
    
    //returns true if user spent less than allocaed budget that day
    func checkForVelocity(goal: Goal, textField: UITextField) -> Bool {
        var stayedUnderBudget = false
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                if amountSpent <= goal.alloctedDailyBudget! {
                    stayedUnderBudget = true
                    print("🔥 sayed under budget \(stayedUnderBudget)")
                }
            }
        }
        return stayedUnderBudget
    }
    
    //updates goal stats based on user input
    func incrementDayAndAmount(goal: Goal, textField: UITextField) {
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                print(goal.currentAmountSaved)
                print(goal.dayCounter)
                
                goal.dayCounter += 1
                
                goal.currentAmountSaved += (goal.dailyBudget - goal.alloctedDailyBudget!) + (goal.alloctedDailyBudget! - amountSpent)
                
                print(goal.currentAmountSaved)
                print(goal.dayCounter)
            }
        }
    }
    
    
    //checks if the goal is complete, if it is it removes it and sets a new goal
    func checkIfComplete(goal: Goal, notify: (Bool) -> Void) {
        if goal.currentAmountSaved >= goal.goalAmount {
            print("currentAmountSaved = \(goal.currentAmountSaved)")
            print("goal amount = \(goal.goalAmount)")
            notify(true)
            store.goals.remove(at: 0)
            if let nextGoal = store.goals.first {
                nextGoal.isActiveGoal = true
            } else {
                print("no queued goals")
            }
        }
    }
    
    
}
