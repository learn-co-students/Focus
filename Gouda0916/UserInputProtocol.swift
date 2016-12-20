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
    
    func checkForVelocity(goal: Goal, textField: UITextField) -> Bool {
        var stayedUnderBudget = false
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                if amountSpent <= goal.alloctedDailyBudget! {
                    stayedUnderBudget = true
                }
            }
        }
        return stayedUnderBudget
    }
    

    func incrementDayAndAmount(goal: Goal, textField: UITextField) {
        if let userInput = textField.text {
            if let amountSpent = Double(userInput) {
                goal.willChangeValue(forKey: "dayCounter")
                goal.dayCounter += 1
                goal.didChangeValue(forKey: "dayCounter")
                goal.willChangeValue(forKey: "currentAmountSaved")
                goal.currentAmountSaved += (goal.dailyBudget - goal.alloctedDailyBudget!) + (goal.alloctedDailyBudget! - amountSpent)
                goal.didChangeValue(forKey: "currentAmountSaved")
                store.saveContext()
            }
        }
    }
    
    
    func checkIfComplete(goal: Goal, notify: (Bool) -> Void) {
        if goal.currentAmountSaved >= goal.goalAmount {
            notify(true)
            store.goals.remove(at: 0)
            store.persistentContainer.viewContext.delete(goal)
            
            if let nextGoal = store.goals.first {
                nextGoal.willChangeValue(forKey: "isActiveGoal")
                nextGoal.isActiveGoal = true
                nextGoal.didChangeValue(forKey: "isActiveGoal")
            } else {
                print("no queued goals")
            }
            
            store.saveContext()
            store.velocityHistory = [Velocity.lastCentury : 0]
            store.velocity = 0
        }
    }
    

    func updateVelocity(success: Bool) {
        var dailyInput: Double {
            if success == true {
                return 10
            } else {
                return 0
            }
        }
        
        for key in store.velocityHistory.keys {
            if Calendar.current.isDateInToday(key) {
                print("Score was already recorded today")
                break
            } else {
                let date = Date()
                let score = calculateVelocityScore(input: dailyInput)
                store.velocityHistory[date] = score
                let context = store.persistentContainer.viewContext
                let DateEntity = VelocityDate(context: context)
                let ScoreEntity = VelocityScore(context: context)
                DateEntity.date = date as NSDate?
                ScoreEntity.score = score
                DateEntity.score = ScoreEntity
                store.saveContext()
            }
        }
    }
    
    func calculateVelocityScore(input: Double) -> Double {
        let yesterday = Date(timeIntervalSinceNow: -86400)
        let twoDaysAgo = Date(timeIntervalSinceNow: -172800)
        var tempArray: [Double] = [input]
        var total: Double = 0
        var score: Double = 0
        
        for (key, value) in store.velocityHistory {
            if key == yesterday {
                tempArray.append(value)
            } else if key == twoDaysAgo {
                tempArray.append(value)
            }
        }
        
        total = tempArray.reduce(0, +)
        score = total / Double(tempArray.count)
        store.velocity = CGFloat(score)
        return score
    }
}
