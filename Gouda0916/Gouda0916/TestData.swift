//
//  TestData.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/16/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

enum WhereToSave {
    case coffee, lunch, drinks, groceries, cloths, entertainment
}

class Goal {
    let desiredPurchase: String
    let purchaseAmount: Double
    let timeToSave: Int
    let currentDailyBudget: Double
    let placesToSave: [WhereToSave] = []
    
    
    init(desiredPurchase: String, purchaseAmount: Double, timeToSave: Int, currentDailyBudget: Double) {
        self.desiredPurchase = desiredPurchase
        self.purchaseAmount = purchaseAmount
        self.timeToSave = timeToSave
        self.currentDailyBudget = currentDailyBudget
        
    }
    
}

class TestData {
    let username: String
    let password: String
    var goals: [Goal] = []
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func serializeTestData() {
        
    }
    
    
    
}

