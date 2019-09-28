//
//  DateFormatter.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var HHmm: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.current
        return formatter
    }

}
