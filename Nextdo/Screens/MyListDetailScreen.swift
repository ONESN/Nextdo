//
//  MyListDetailScreen.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import SwiftUI
import SwiftData

struct MyListDetailScreen: View {
    
    let myList: MyList
    @State private var title: String = ""
    @State private var isNewNextdoPresenten: Bool = false
    @State private var showNextdoEditScreen: Bool = false
    
    @State private var selectedNextdo: Nextdo?
    
    @Environment(\.modelContext) private var context
    
    private let delay = Delay()
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace
    }
    
    private func saveNextdo() {
        let nextdo = Nextdo(title: title)
        myList.nextdos.append(nextdo)
    }
    
    private func isNextdoSelected(_ nextdo: Nextdo) -> Bool {
        nextdo.persistentModelID == selectedNextdo?.persistentModelID
    }
    
    private func deleteNextdo(_ indexSet: IndexSet) {
        guard let index = indexSet.last else { return }
        let nextdo = myList.nextdos[index]
        context.delete(nextdo)
    }
    
    var body: some View {
        VStack {
            NextdoListView(nextdos: myList.nextdos.filter{ !$0.isCompleted })
            
            Spacer()
            Button(action: {
                isNewNextdoPresenten = true
            }, label: {
                HStack{
                    Image(systemName: "plus.circle.fill")
                    Text("新增提醒事项")
                }
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }.navigationTitle(myList.name)
            .alert("新建提醒", isPresented: $isNewNextdoPresenten) {
                TextField("", text: $title)
                Button("取消", role: .cancel) {  }
                Button("完成") {
                    saveNextdo()
                    title = ""
                }.disabled(!isFormValid)
            }
            .navigationTitle(myList.name)
            .sheet(isPresented: $showNextdoEditScreen, content: {
                if let selectedNextdo {
                    NavigationStack {
                        NextdoEditScreen(nextdo: selectedNextdo)
                    }
                }
            })
    }
}

struct MyListDetailScreenContainer: View {
    
    @Query private var myLists: [MyList]
    
    var body: some View {
        MyListDetailScreen(myList: myLists[0])
    }
}
#Preview { @MainActor in
    NavigationStack {
        MyListDetailScreenContainer()
    }.modelContainer(previewContainer)
}
