//
//  NextdoListView.swift
//  Nextdo
//
//  Created by 君の名は on 9/20/24.
//

import SwiftUI
import SwiftData

struct NextdoListView: View {
    let nextdos: [Nextdo]
    @Environment(\.modelContext) private var context
    
    @State private var selectedNextdo: Nextdo? = nil
    @State private var showNextdoEditScreen: Bool = false
    
    private let delay = Delay()
    
    private func deleteNextdo(_ indexSet: IndexSet) {
        guard let index = indexSet.last else { return }
        let nextdo = nextdos[index]
        context.delete(nextdo)
    }
    
    var body: some View {
        List{
            ForEach(nextdos) { nextdo in
                NextdoCellView(nextdo: nextdo) {event in
                    switch event {
                    case .onChecked(let nextdo, let checked):
                        //cancel pending task
                        //delay.cancel()
                        delay.perforWork{
                            nextdo.isCompleted = checked
                        }
                    case .onSelect(let nextdo):
                        selectedNextdo = nextdo
                    }
                }
                
            }
            .onDelete(perform: deleteNextdo)
        }.sheet(item: $selectedNextdo, content: { selecteNextdo in
            NavigationStack {
                NextdoEditScreen(nextdo: selecteNextdo)
            }
        })
    }
}

