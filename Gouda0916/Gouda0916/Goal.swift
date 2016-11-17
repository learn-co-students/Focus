//
//  Goal.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/17/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation


class Goal {
    let goal: Double
    let timeframe: Int
    let dailyBudget: Double
    let goalPurchase: String
    let userInput: [String:Any]
    let waysToSave = "Lunch"
    var dayCounter = 1
    var currentAmountSaved = 0.0
    var alloctedDailyBudget: Double {
        return (goal - currentAmountSaved / Double(timeframe)) - dailyBudget
    }
    
    init(userInput: [String:Any]) {
        self.goal = userInput["goal"] as! Double
        self.timeframe = userInput["timeframe"] as! Int
        self.dailyBudget = userInput["daily_budget"] as! Double
        self.goalPurchase = userInput["goal_purchase"] as! String
        self.userInput = userInput
        
    }
    
    func serializeGoalIntoDictionary() -> [String:Any] {
        var serializedGoal: [String:Any] = userInput
        
        serializedGoal["day_counter"] = dayCounter
        serializedGoal["current_amount_saved"] = currentAmountSaved
        serializedGoal["allocated_daily_budget"] = alloctedDailyBudget
        
        return serializedGoal
    }
}
