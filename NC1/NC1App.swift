//
//  NC1App.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/13/24.
//

import SwiftUI
import SwiftData

@main
struct NC1App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Journey.self,
            Block.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabSplitView()
                .preferredColorScheme(.dark)
//            DiaryView()
//            ContentView()
//            ListDropDown()
        }
//        .modelContainer(for: [Journey.self, Block.self])
        .modelContainer(sharedModelContainer)
        .environment(\.locale, .init(identifier: "ko_KR"))
    }
}
