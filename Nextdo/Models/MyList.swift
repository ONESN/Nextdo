//
//  MyList.swift
//  Nextdo
//
//  Created by 君の名は on 9/18/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model class MyList {
    var name: String
    var colorCode: String
    
    @Relationship(deleteRule: .cascade)
    var nextdos: [Nextdo] = []
    
    init(name: String, colorCode: String) {
        self.name = name
        self.colorCode = colorCode
    }
}
