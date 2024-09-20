//
//  Nextdo.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import Foundation
import SwiftData

@Model class Nextdo {
    var title: String
    var notes: String?
    var isCompleted: Bool
    var nextdoDate: Date?
    var nextdoTime: Date?
    
    var list: MyList?
    
    init(title: String, notes: String? = nil, isCompleted: Bool = false, NextdoDate: Date? = nil, NextdoTime: Date? = nil, list: MyList? = nil) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.nextdoDate = NextdoDate
        self.nextdoTime = NextdoTime
        self.list = list
    }
}
