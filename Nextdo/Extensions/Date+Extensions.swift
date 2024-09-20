//
//  Date+Extensions.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import Foundation


extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
}

