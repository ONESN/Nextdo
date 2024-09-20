//
//  AddMyListScreen.swift
//  Nextdo
//
//  Created by 君の名は on 9/18/24.
//

import SwiftUI

struct AddMyListScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var color: Color = .blue
    @State private var listName: String = ""
    
    var myList: MyList? = nil
    
    var body: some View {
        VStack{
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(color)
            
            TextField("列表名称", text: $listName)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 44)
            
            ColorPickerView(selectedColor: $color)  //$color为颜色选择器
        }
        .onAppear(perform: {
            if let myList {
                listName = myList.name
                color = Color(hex: myList.colorCode)
            }
        })
        .navigationTitle("新建列表")
        .navigationBarTitleDisplayMode(.inline) //使用内联显示模式
        .toolbar {  //在导航栏增加操作按钮
            ToolbarItem(placement: .topBarLeading) {
                Button("取消") {
                    dismiss()
                }
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("完成") {
                    if let myList {
                        myList.name = listName
                        myList.colorCode = color.toHex() ?? ""
                    } else {
                        guard let hex = color.toHex() else { return }
                        let myList = MyList(name: listName, colorCode: hex)
                        context.insert(myList)
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview { @MainActor in
    NavigationStack {
        AddMyListScreen()
    }.modelContainer(previewContainer)
}
