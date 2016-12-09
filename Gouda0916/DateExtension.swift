//
//  DateExtension.swift
//  Gouda0916
//
//  Created by Michael Young on 12/7/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

public extension Date {
    
    static let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    
    
    // MARK: Intervals In Seconds
    private static func minuteInSeconds() -> Double { return 60 }
    private static func hourInSeconds() -> Double { return 3600 }
    private static func dayInSeconds() -> Double { return 86400 }
    private static func weekInSeconds() -> Double { return 604800 }
    private static func yearInSeconds() -> Double { return 31556926 }
    
    func isEqual(to: String) {
        
    }
    
    
}
