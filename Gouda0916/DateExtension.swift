//
//  DateExtension.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/20/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

extension Date {
    func dayOfTheWeek() -> String {
        var dayString = "Current"
        let calendar = Calendar.current
        let components: DateComponents = calendar.dateComponents([.weekday], from: self)
        let dayInt = components.weekday
        
        if let dayInt = dayInt {
            switch dayInt {
            case 1:
                dayString = "Sunday"
            case 2:
                dayString = "Monday"
            case 3:
                dayString = "Tuesday"
            case 4:
                dayString = "Wednesday"
            case 5:
                dayString = "Thursday"
            case 6:
                dayString = "Friday"
            case 7:
                dayString = "Saturday"
            default:
                break
            }
        }
        return dayString
    }
}
