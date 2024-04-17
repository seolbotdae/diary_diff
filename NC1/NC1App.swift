//
//  NC1App.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/13/24.
//

import SwiftUI

@main
struct NC1App: App {
    var body: some Scene {
        WindowGroup {
            TabSplitView()
                .preferredColorScheme(.dark)
//            DiaryView()
//            ContentView()
//            ListDropDown()
        }
        .environment(\.locale, .init(identifier: "ko_KR"))
    }
}
