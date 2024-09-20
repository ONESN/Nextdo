//
//  NextdoApp.swift
//  Nextdo
//
//  Created by 君の名は on 9/17/24.
//

import SwiftUI
import SwiftData

@main
struct NextdoApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MyListsScreen()
            }.modelContainer(for: MyList.self)
        }
    }
}
