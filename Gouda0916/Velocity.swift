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

    static let lastCentury = Date(timeIntervalSinceNow: -3.154e+9)
    
    init() {}
    
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
                store.currentVelocityScore = Double(store.graphPoints[store.graphPoints.count - 2])
            }
        }
    }
    
    
    
    func saveVelocityHistoy() {}
    
    func fetchVelocityHistoy() {}
}



