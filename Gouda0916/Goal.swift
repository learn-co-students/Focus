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
    let goalPurchase: String
    let waysToSave: String
    var dayCounter = 1
    var currentAmountSaved = 0.0
    let dailyBudget: Double
    var alloctedDailyBudget: Double {
        return (goal / Double(timeframe)) - dailyBudget
    }
    
    init(goal: Double, timeframe: Int, dailyBudget: Double, goalPurchase: String, waysToSave: String) {
        self.goal = goal
        self.timeframe = timeframe
        self.dailyBudget = dailyBudget
        self.goalPurchase = goalPurchase
        self.waysToSave = waysToSave
        
    }
    
    func serializeGoalIntoDictionary() -> [String : Any] {
        var serializedGoal: [String : Any] = [ : ]
        
        serializedGoal["goal"] = goal
        serializedGoal["timeframe"] = timeframe
        serializedGoal["daily_budget"] = dailyBudget
        serializedGoal["goal_purchase"] = goalPurchase
        serializedGoal["ways_to_save"] = waysToSave
        serializedGoal["day_counter"] = dayCounter
        serializedGoal["current_amount_saved"] = currentAmountSaved
        serializedGoal["allocated_daily_budget"] = alloctedDailyBudget
        
        return serializedGoal
    }
}
