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
    var store = DataStore.sharedInstance
    
    var tracker: [Int]?
    var score = Int()
    var velocityTrend: [String: Int] = [date: 0]
    
    static let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    
    func calculateScore() {
        var total: Int = 0
        
        guard let tracker = tracker else { return }
        
        if tracker.count <= 3 {
            total = tracker.reduce(0, +)
            score = total / tracker.count
        } else {
            let firstIndex = tracker.count - 3
            let secondIndex = tracker.count - 2
            let thirdIndex = tracker.count - 1
            
            total = firstIndex + secondIndex + thirdIndex
            score = total / 3
            
            var scoreForCircle = 552 - ((CGFloat(score))/552)
            store.velocity = scoreForCircle
            
        }
    }
}



