//
//  Velocity.swift
//  Gouda0916
//
//  Created by Michael Young on 11/22/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation
import CoreData
import CoreGraphics

class Velocity {
    
    let store = DataStore.sharedInstance
    let defaults = UserDefaults.standard
    let defaultKey = "VelocityHistory"
    
    let calendar = Calendar(identifier: .gregorian)
    let today = Date()
    
    // Temp
    static let yesterday = Date(timeIntervalSinceNow: -86400)
    static let twoDaysAgo = Date(timeIntervalSinceNow: -172800)
    static let threeDaysAgo = Date(timeIntervalSinceNow: -259200)
    static let fourDaysAgo = Date(timeIntervalSinceNow: -345600)
    static let fiveDaysAgo = Date(timeIntervalSinceNow: -432000)
    static let sixDaysAgo = Date(timeIntervalSinceNow: -518400)
    static let sevenDaysAgo = Date(timeIntervalSinceNow: -604800)
    static let eightDaysAgo = Date(timeIntervalSinceNow: -691200)
    static let nineDaysAgo = Date(timeIntervalSinceNow: -777600)
    static let tenDaysAgo = Date(timeIntervalSinceNow: -864000)
    static let elevenDaysAgo = Date(timeIntervalSinceNow: -950400)
    static let twelveDaysAgo = Date(timeIntervalSinceNow: -1.037e+6)
    static let thirteenDaysAgo = Date(timeIntervalSinceNow: -1.123e+6)

    static let lastYear = Date(timeIntervalSinceNow: -3.154e+7)
    
    init() {}
    
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
                return
            } else {
                store.velocityHistory[Date()] = calculateVelocityScore(input: dailyInput)
                // Test Data
                print("Before Save and Fetch: \(store.velocityHistory)")
                print("Score Added")
            }
        }
    }
    
    func calculateVelocityScore(input: Double) -> Double {
        
        var tempArray: [Double] = [input]
        var total: Double = 0
        var score: Double = 0
        
        for (key, value) in store.velocityHistory {
            if key == Velocity.yesterday {
                tempArray.append(value)
            } else if key == Velocity.twoDaysAgo {
                tempArray.append(value)
            }
        }
        
        print("History Count: \(store.velocityHistory.count)")
        print("TEMP ARRAY: \(tempArray)")
        total = tempArray.reduce(0, +)
        score = total / Double(tempArray.count)
        
        return score
    }
    
    func updateGraph(for week: String) {
        
        var thisWeekArray: [Int] = [0]
        var lastWeekArray: [Int] = [0]
        let sortedVelocityHistory = store.velocityHistory.sorted(by: { $0.0 > $1.0 })
        
        let thisWeekStart = Date(timeIntervalSinceNow: -604800)
        let thisWeekEnd = Date()
        let thisWeekRange = (thisWeekStart...thisWeekEnd)
        
        let lastWeekStart = Date(timeInterval: -1.21e+6, since: Date())
        let lastWeekEnd = Date(timeInterval: -604800, since: Date())
        let lastWeekRange = (lastWeekStart...lastWeekEnd)
        
        print("this week range: \(thisWeekRange)")
        print("last week range: \(lastWeekRange)")
        
        for (key, value) in sortedVelocityHistory {
            if thisWeekRange.contains(key) {
                thisWeekArray.append(Int(value))
            } else if lastWeekRange.contains(key) {
                lastWeekArray.append(Int(value))

            }
            
            switch week {
            case "This Week":
                store.graphPoints = thisWeekArray
                store.graphPoints.append(0)
                standardizeGraphPoints()
            case "Last Week":
                store.graphPoints = lastWeekArray
                store.graphPoints.append(0)
                standardizeGraphPoints()
            default:
                break
            }
        }
    }
    
    func standardizeGraphPoints() {
        let pointCount = store.graphPoints.count
        print("PointS: \(pointCount)")
        let pointsNeeded = 9 - pointCount
        
        if pointCount < 9 {
            for count in 1...pointsNeeded {
                store.graphPoints.insert(0, at: count)
            }
        }
    }
    
    
    
    func saveVelocityHistoy() {}
    
    func fetchVelocityHistoy() {}
}



