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
        let amountNeededPerDay = (goalAmount - currentAmountSaved) / timeframe
        return dailyBudget - (amountNeededPerDay)
    }

    func serializeGoalIntoDictionary() -> [String : Any] {
        var serializedGoal: [String : Any] = [ : ]
        
        serializedGoal["goal"] = goalAmount
        serializedGoal["timeframe"] = timeframe
        serializedGoal["daily_budget"] = dailyBudget
        serializedGoal["goal_purchase"] = purchasGoal
        serializedGoal["way_to_save"] = wayToSave
        serializedGoal["day_counter"] = dayCounter
        serializedGoal["current_amount_saved"] = currentAmountSaved
        serializedGoal["allocated_daily_budget"] =  alloctedDailyBudget
        serializedGoal["is_active_goal"] = isActiveGoal
        if
            let startDate = startDate,
            let endDate = endDate{
                serializedGoal["start_date"] = "\(startDate)"
                serializedGoal["end_date"] = "\(endDate)"
        }
        
        return serializedGoal
    }
    //already have end dates (located in create goal view controller)
    //take in two dates - date when goal starts, date when goal ends
    //return the difference
    
    
    
    
    
    
}
