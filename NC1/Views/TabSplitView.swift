//
//  TabSplitView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/15/24.
//

import SwiftUI

struct TabSplitView: View {
    @State var selection = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                DiaryView()
                    .tabItem {
                        Label("일기", systemImage: "pencil.circle.fill")
                    }.tag(1)
                
                DiaryListView()
                    .tabItem {
                        Label("지난 기록", systemImage: "list.bullet.clipboard.fill")
                    }.tag(2)
            }
            .navigationTitle(selection == 1 ? "일기" : "지난 기록")
        }
        
    }
}
