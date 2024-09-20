//
//  MyList.swift
//  Nextdo
//
//  Created by 君の名は on 9/18/24.
//

import SwiftUI
import SwiftData

enum NextdoStatsType: Int, Identifiable {
    
    case today
    case scheduled
    case all
    case completed
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .today:
            return "今天"
        case .scheduled:
            return "日历"
        case .all:
            return "全部"
        case .completed:
            return "完成"
        }
    }
}


struct MyListsScreen: View {
    
    //创建一个列表，这是一个示例
    @Query private var myLists: [MyList]
    @Query private var nextdos: [Nextdo]
    
    @State private var isPresented: Bool = false
    @State private var selectedList: MyList?
    
    @State private var actionSheet: MyListScreenSheets?
    @State private var nextdoStatsType: NextdoStatsType?
    
    
    
    enum MyListScreenSheets: Identifiable {
        case newList
        case editList(MyList)
        
        var id: Int {
            switch self {
            case .newList:
                return 1
            case .editList(let myList):
                return myList.hashValue
            }
        }
    }
    
    private var inCompleteNextdos: [Nextdo] {
        nextdos.filter { !$0.isCompleted }
    }
    
    private var todaysNextdos: [Nextdo] {
        nextdos.filter {
            guard let nextdoDate = $0.nextdoDate  else {
                return false
            }
            return nextdoDate.isToday && !$0.isCompleted
        }
    }
    
    private var scheduledNextdo: [Nextdo] {
        nextdos.filter {
            $0.nextdoDate != nil && !$0.isCompleted
        }
    }
    
    private var completeNextdos: [Nextdo] {
        nextdos.filter { $0.isCompleted }
    }
    
    private func nextdos(for type: NextdoStatsType) -> [Nextdo] {
        switch type {
        case .all:
            return inCompleteNextdos
        case .scheduled:
            return scheduledNextdo
        case .today:
            return todaysNextdos
        case .completed:
            return completeNextdos
        }
    }
    
    var body: some View {
        List {
            
            VStack {
                HStack {
                    NextdoStatsView(icon: "calendar", title: "今天", count: todaysNextdos.count)
                        .onTapGesture {
                            nextdoStatsType = .today
                        }
                    NextdoStatsView(icon: "salendar.circle", title: "日历", count: scheduledNextdo.count)
                        .onTapGesture {
                            nextdoStatsType = .scheduled
                        }
                }
                HStack {
                    NextdoStatsView(icon: "tray.circle.fill", title: "全部", count: inCompleteNextdos.count)
                        .onTapGesture {
                            nextdoStatsType = .all
                        }
                    NextdoStatsView(icon: "checkmark.circle.fill", title: "完成", count: completeNextdos.count)
                        .onTapGesture {
                            nextdoStatsType = .completed
                        }
                }
            }
            
            ForEach(myLists) { myList in
                NavigationLink(value: myList) {
                    MyListCellView(myList: myList)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedList = myList
                        }
                        .onLongPressGesture(minimumDuration: 0.5) {
                            actionSheet = .editList(myList)
                        }
                }
                
            }
            
            Button(action: {
                actionSheet = .newList
            }, label: {
                Text("添加列表")
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }).listRowSeparator(.hidden)    //隐藏列表下划线
            
        }
        .navigationTitle("我的列表")
        .navigationDestination(item: $selectedList, destination: { myList in
            MyListDetailScreen(myList: myList)
        })
        .navigationDestination(item: $nextdoStatsType, destination: { nextdoStatsType in
            NavigationStack {
                NextdoListView(nextdos: nextdos(for: nextdoStatsType))
                    .navigationTitle(nextdoStatsType.title)
            }
            
        })
        
        .listStyle(.plain)
        .sheet(item: $actionSheet) { actionSheet in
            switch actionSheet {
            case .newList:
                NavigationStack{
                    AddMyListScreen()
                }
            case .editList(let myList):
                NavigationStack{
                    AddMyListScreen(myList: myList)
                }
            }
        }
    }
}

#Preview("Light Mode") { @MainActor in
    NavigationStack {
        MyListsScreen()
    }.modelContainer(previewContainer)
}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        MyListsScreen()
    }.modelContainer(previewContainer)
        .environment(\.colorScheme, .dark)
}
