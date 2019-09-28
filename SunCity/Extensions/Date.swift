//
//  Date.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation

extension Date {

    // Have a time stamp formatter to avoid keep creating new ones. This improves performance
    private static let weekdayAndDateStampDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "EEEE, MMM dd yyyy" // "Monday, Mar 7 2016"
        return dateFormatter
    }()

    func toWeekDayAndDateString() -> String {
        return Date.weekdayAndDateStampDateFormatter.string(from: self)
    }

}
