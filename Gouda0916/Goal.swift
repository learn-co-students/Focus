//
//  GoalExtension.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/21/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


extension Goal {
    
    var alloctedDailyBudget: Double? {
        return (goalAmount / timeframe) - dailyBudget
    }
    
    var waysToSaveAsStrings: [String] {
        var array: [String] = []
        for way in waysToSave?.allObjects as! [WayToSave] {
            if let way = way.way {
                array.append(way)
            }
        }
        return array
    }

    func serializeGoalIntoDictionary() -> [String : Any] {
        var serializedGoal: [String : Any] = [ : ]
        
        serializedGoal["goal"] = goalAmount
        serializedGoal["timeframe"] = timeframe
        serializedGoal["daily_budget"] = dailyBudget
        serializedGoal["goal_purchase"] = purchasGoal
        serializedGoal["ways_to_save"] = waysToSaveAsStrings
        serializedGoal["day_counter"] = dayCounter
        serializedGoal["current_amount_saved"] = currentAmountSaved
        serializedGoal["allocated_daily_budget"] =  alloctedDailyBudget
        
        print(serializedGoal)
        
        return serializedGoal
    }
}
