//
//  NextdoCellView.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import SwiftUI
import SwiftData

enum NextdoCellEvents {
    case onChecked(Nextdo, Bool)
    case onSelect(Nextdo)
}

struct NextdoCellView: View {
    
    let nextdo: Nextdo
    let delay = Delay()
    let onEvent: (NextdoCellEvents) -> Void
    @State private var checked: Bool = false
    
    private func formatNextdoDate(_ date: Date) -> String {
        if date.isToday {
            return "今天"
        } else if date.isTomorrow {
            return "明天"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
        
    }
    
    var body: some View {
        HStack(alignment: .top){
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .padding([.trailing], 5)
                .foregroundColor(.blue)
                .onTapGesture {
                    //
                    checked.toggle()
                        onEvent(.onChecked(nextdo, checked))
                    
                }
            
            VStack {
                Text(nextdo.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let notes = nextdo.notes {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    if let nextdoDate = nextdo.nextdoDate {
                        Text(formatNextdoDate(nextdoDate))
                    }
                    
                    if let nextdoTime = nextdo.nextdoTime {
                        Text(nextdoTime, style: .time)
                    }
                }.font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(nextdo))
            }
    }
}

struct NextdoCellViewContainer: View {
    
    @Query(sort: \Nextdo.title) private var nextdos: [Nextdo]
    var body: some View {
        NextdoCellView(nextdo: nextdos[0]) { _ in
            
        }
    }
}

#Preview { @MainActor in
    NextdoCellViewContainer()
        .modelContainer(previewContainer)
}
