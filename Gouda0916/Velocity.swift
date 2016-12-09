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
    
    var velocityHistory = [Date : Double]()
    
    let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)

    let yesterday = Date(timeIntervalSinceNow: -86400)
    let twoDaysAgo = Date(timeIntervalSinceNow: -172800)
    let threeDaysAgo = Date(timeIntervalSinceNow: -259200)
    let fourDaysAgo = Date(timeIntervalSinceNow: -345600)
    let fiveDaysAgo = Date(timeIntervalSinceNow: -432000)
    let sixDaysAgo = Date(timeIntervalSinceNow: -518400)
    
    let lastYear = Date(timeIntervalSinceNow: -3.154e+7)
    
    init() {
        self.velocityHistory = [lastYear : 100]
    }
    
    func updateVelocity(success: Bool) {

        
        var dailyInput: Double {
            if success == true {
                return 10
            } else {
                return 0
            }
        }
        
        for key in self.velocityHistory.keys {
            if Calendar.current.isDateInToday(key) {
                print("Score was already recorded today")
                break
            } else {
                self.velocityHistory[Date()] = calculateVelocityScore(input: dailyInput)
                self.saveDefaultData()
                print("Score Added")
            }
        }
    }
    
    func calculateVelocityScore(input: Double) -> Double {
        
        var tempArray: [Double] = [input]
        var total: Double = 0
        var score: Double = 0
        
        for (key, value) in self.velocityHistory {
            if key == yesterday {
                tempArray.append(value)
            } else if key == twoDaysAgo {
                tempArray.append(value)
            }
        }
        
        print("History Count: \(self.velocityHistory.count)")
        print("TEMP ARRAY: \(tempArray)")
        total = tempArray.reduce(0, +)
        score = total / Double(tempArray.count)
        
        return score
    }
    
    func updateGraph(for week: String) {
        
        //        var thisWeek: [Int] = [0]
        //        var nextWeek: [Int] = [0]
        //
        //        for key in velocityHistory.keys {
        //            if key == today
        //        }
        
        switch week {
        case "This Week":
            // Test Data
            store.graphPoints = [0, 10, 5, 8, 10, 10, 8, 2, 0]
        case "Last Week":
            // Test Data
            store.graphPoints = [9, 10, 8, 10, 10, 8, 1, 6, 10]
        default:
            // Test Data
            store.graphPoints = [0, 0, 0, 0, 0, 0, 0, 0, 0,]
            
        }
    }
    
    func saveDefaultData() {
        for (key, value) in velocityHistory {
            defaults.set("\(key)_\(value)", forKey: self.defaultKey)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    let store = DataStore.sharedInstance
    //    let defaults = UserDefaults.standard
    //    let dateFormatter = DateFormatter()
    //    //var velocityHistory = [Date : Double]()
    //
    //    let today = Date()
    //    let yesterday = Date(timeIntervalSinceNow: -86400)
    //    let twoDaysAgo = Date(timeIntervalSinceNow: -172800)
    //    let threeDaysAgo = Date(timeIntervalSinceNow: -259200)
    //    let fourDaysAgo = Date(timeIntervalSinceNow: -345600)
    //    let fiveDaysAgo = Date(timeIntervalSinceNow: -432000)
    //    let sixDaysAgo = Date(timeIntervalSinceNow: -518400)
    //
    //    let lastYear = Date(timeIntervalSinceNow: -3.154e+7)
    //
    //    init() {
    //        //self.velocityHistory = [lastYear : 100]
    //    }
    //
    //
    //    //static let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    //
    //    func updateVelocity(success: Bool) {
    //
    //        //defaults.set(9999999999999.99999999999999999, forKey: "test")
    //        //let velocityHistory = defaults.dictionaryRepresentation()
    //        //dump(velocityHistory.keys)
    //        var velocityHistory = [Date : Double]()
    //        var dailyInput: Double {
    //            if success == true {
    //                return 10
    //            } else {
    //                return 0
    //            }
    //        }
    //
    //        for key in velocityHistory.keys {
    //
    //            if Calendar.current.isDateInToday(key) {
    //                    print("**************************************************Score was already recorded today")
    //                    break
    //                } else {
    //                    let score = calculateVelocityScore(input: dailyInput)
    //                    velocityHistory[Date()] = score
    //                    print("*************************************************************Score Added")
    //                }
    //            }
    //
    //            print("**************************************************didn't enter loop")
    //            print(velocityHistory.keys.count)
    //
    //    }
    //
    //    func calculateVelocityScore(input: Double) -> Double {
    //
    //        let velocityHistory = defaults.dictionaryRepresentation()
    //        var tempArray: [Double] = [input]
    //        var total: Double = 0
    //        var score: Double = 0
    //
    //        for (key, value) in velocityHistory {
    //            // Unwrap Dates
    //            // Yesterday
    //            if Calendar.current.isDateInYesterday(self.dateFormatter.date(from: key)!) {
    //                tempArray.append(value as! Double)
    //                // Day before yesterday
    //            } else if Calendar.current.isDate(self.dateFormatter.date(from: key)!, inSameDayAs: twoDaysAgo) {
    //                tempArray.append(value as! Double)
    //            }
    //        }
    //
    //        print("History Count: \(velocityHistory.count)")
    //        print("TEMP ARRAY: \(tempArray)")
    //        total = tempArray.reduce(0, +)
    //        score = total / Double(tempArray.count)
    //
    //        return score
    //    }
    //
    //    func updateGraph(for week: String) {
    //
    //        //        var thisWeek: [Int] = [0]
    //        //        var nextWeek: [Int] = [0]
    //        //
    //        //        for key in velocityHistory.keys {
    //        //            if key == today
    //        //        }
    //
    //        switch week {
    //        case "This Week":
    //            // Test Data
    //            store.graphPoints = [0, 10, 5, 8, 10, 10, 8, 2, 0]
    //        case "Last Week":
    //            // Test Data
    //            store.graphPoints = [9, 10, 8, 10, 10, 8, 1, 6, 10]
    //        default:
    //            // Test Data
    //            store.graphPoints = [0, 0, 0, 0, 0, 0, 0, 0, 0,]
    //
    //        }
    //    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    var store = DataStore.sharedInstance
    //
    //    var tracker: [Int] = [0]
    //    var score = Int()
    //
    //    var velocityHistory: [String: Double] = [Date.today: 10.0]
    //
    //
    //    static let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    //
    //
    //    func calculateScore() -> Int {
    //        var total: Int = 0
    //        var score = Int()
    //
    //        //guard let tracker = tracker else { return 100 }
    //
    //        if tracker.count <= 3 {
    //            total = tracker.reduce(0, +)
    //            score = total / tracker.count
    //        } else {
    //            let firstIndex = tracker.count - 3
    //            let secondIndex = tracker.count - 2
    //            let thirdIndex = tracker.count - 1
    //
    //            total = firstIndex + secondIndex + thirdIndex
    //            score = total / 3
    //
    //            var scoreForCircle = 552 - ((CGFloat(score))/552)
    //            store.velocity = scoreForCircle
    //
    //        }
    //        return score
    //    }
    //
    //    func updateVelocityTracker(points: Int) {
    //        tracker.append(points)
    //    }
    //
    //    func updateVelocityTrend(score: Double) {
    //        for key in velocityHistory.keys {
    //            if key == Velocity.date {
    //                break
    //            } else {
    //                velocityHistory[Velocity.date] = score
    //            }
    //        }
    //    }
}



