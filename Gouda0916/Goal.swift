//
//  Goal.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/17/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation


//class Goal {
//    var goal: Double
//    var timeframe: Int
//    var goalPurchase: String
//    var waysToSave: [String]
//    var dayCounter = 1
//    var currentAmountSaved = 0.0
//    var dailyBudget: Double
//    var alloctedDailyBudget: Double {
//        return (goal / Double(timeframe)) - dailyBudget
//    }
//    
//    init(goal: Double, timeframe: Int, dailyBudget: Double, goalPurchase: String, waysToSave: [String]) {
//        self.goal = goal
//        self.timeframe = timeframe
//        self.dailyBudget = dailyBudget
//        self.goalPurchase = goalPurchase
//        self.waysToSave = waysToSave
//        
//    }
//    
//    convenience init (goalData: GoalData) {
//        let goalz = goalData.goalAmount
//        let timeframez = goalData.timeframe
//        let dailyBudgetz = goalData.dailyBudget
//        let goalPurchasez = goalData.purchasGoal
//        let waysToSavez = goalData.waysToSave?.allObjects as! [String]
//        self.init(goal: goalz, timeframe: Int(timeframez), dailyBudget: dailyBudgetz, goalPurchase: goalPurchasez!, waysToSave: waysToSavez)
//        
//    }
//    
//    func serializeGoalIntoDictionary() -> [String : Any] {
//        var serializedGoal: [String : Any] = [ : ]
//        
//        serializedGoal["goal"] = goal
//        serializedGoal["timeframe"] = timeframe
//        serializedGoal["daily_budget"] = dailyBudget
//        serializedGoal["goal_purchase"] = goalPurchase
//        serializedGoal["ways_to_save"] = waysToSave
//        serializedGoal["day_counter"] = dayCounter
//        serializedGoal["current_amount_saved"] = currentAmountSaved
//        serializedGoal["allocated_daily_budget"] = alloctedDailyBudget
//        
//        return serializedGoal
//    }
//}
