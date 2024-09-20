//
//  NextdoEditScreen.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import SwiftUI
import SwiftData

struct NextdoEditScreen: View {
    
    let nextdo: Nextdo
    
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var nextdoDate: Date = .now
    @State private var nextdoTime: Date = .now
    
    @State private var showCalender: Bool = false
    @State private var showTime: Bool = false
    
    private func updateNextdo() {
        nextdo.title = title
        nextdo.notes = notes.isEmpty ? nil: notes
        nextdo.nextdoDate = showCalender ? nextdoDate: nil
        nextdo.nextdoTime = showTime ? nextdoTime: nil
    }
    
    //确保这是一个有效提醒事项
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace
    }
    
    var body: some View {
        Form {
            Section {
                TextField("标题", text: $title)
                TextField("备注", text: $notes)
            }

            Section {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.red)
                        .font(.title2)
                    Text("日期")
                    Toggle(isOn: $showCalender) {
                        EmptyView()
                    }
                  
                }
                
                if showCalender {
                    DatePicker("Select Date", selection: $nextdoDate, in: .now..., displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(.blue)
                        .font(.title2)
                    
                    Text("时间")
                    
                    Toggle(isOn: $showTime) {
                        EmptyView()
                    }
                   
                }
                
                if showTime {
                    DatePicker("Select Time", selection: $nextdoTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle()) // 使用滚轮样式的时间选择器
                }
            }


        }.onAppear(perform: {
            title = nextdo.title
            notes = nextdo.notes ?? ""
            nextdoDate = nextdo.nextdoDate ?? Date()
            nextdoTime = nextdo.nextdoTime ?? Date()
            showTime = nextdo.nextdoTime != nil
            showCalender = nextdo.nextdoDate != nil
        })
        .navigationTitle("详细信息")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("取消") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("完成") {
                    updateNextdo()
                    dismiss()
                }.disabled(!isFormValid)
            }
        }
    }
}

struct NextdoEditScreenContainer: View {
    @Query(sort: \Nextdo.title) private var nextdos: [Nextdo]
    
    var body: some View {
        NextdoEditScreen(nextdo: nextdos[0])
    }
}

#Preview {
    NavigationStack {
        NextdoEditScreenContainer()
    }.modelContainer(previewContainer)
}
