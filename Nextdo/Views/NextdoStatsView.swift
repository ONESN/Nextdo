//
//  NextdoStatsView.swift
//  Nextdo
//
//  Created by 君の名は on 9/20/24.
//

import SwiftUI

struct NextdoStatsView: View {
    
    let icon: String
    let title: String
    let count: Int
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(spacing: 10) {
                    Image(systemName: icon)
                    Text(title)
                }
                Spacer()
                Text("\(count)")
                    .font(.largeTitle)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    NextdoStatsView(icon: "日历", title: "今天", count: 2)
}
