//
//  PreviewContainer.swift
//  Nextdo
//  创建一个预览窗口用于预览本地静态开发数据
//  Created by 君の名は on 9/18/24.
//

import Foundation
import SwiftData


@MainActor
var previewContainer: ModelContainer = {
    let container = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for myList in SampleDate.myLists {
        container.mainContext.insert(myList)
        myList.nextdos = SampleDate.Nextdos
    }
    
    return container
}()

struct SampleDate {
    static var myLists: [MyList] {
        return [MyList(name: "提醒", colorCode: "ea05rw"), MyList(name: "Backlog", colorCode: "02edf3")]
    }
    
    static var Nextdos: [Nextdo] {
        return [Nextdo(title: "提醒事项1", notes: "这是提醒事项2的notes", NextdoDate: Date(), NextdoTime: Date()), Nextdo(title: "提醒事项2", notes: "这是提醒事项2的notes")]
    }
}
