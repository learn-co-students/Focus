//
//  Velocity.swift
//  Gouda0916
//
//  Created by Michael Young on 11/22/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

class Velocity {
    var tracker: [Int] = [0]
    var velocityTrend: [String: Int] = [date: 0]
    
    static let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    
    func calculateScore() -> Int {
        var total: Int = 0
        var score = Int()
        
        //guard let tracker = tracker else { return 100 }
        
        if tracker.count <= 3 {
            total = tracker.reduce(0, +)
            score = total / tracker.count
        } else {
            let firstIndex = tracker.count - 3
            let secondIndex = tracker.count - 2
            let thirdIndex = tracker.count - 1
            
            total = firstIndex + secondIndex + thirdIndex
            score = total / 3
        }
        return score
    }
    
    func updateVelocityTracker(points: Int) {
        tracker.append(points)
    }
    
    func updateVelocityTrend(score: Int) {
        for key in velocityTrend.keys {
            if key == Velocity.date {
                break
            } else {
                velocityTrend[Velocity.date] = score
            }
        }
    }
}
