//
//  DiaryListView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/19/24.
//

import SwiftUI
import SwiftData

struct DiaryListView: View {
    @Query private var journey: [Journey]
    
    var body: some View {
        VStack {
            List {
                ForEach(journey, id: \.id) { item in
                    Section {
                        ItemView(journey: item)
                    }
                    .listSectionSpacing(12)
                }
            }
        }
        .padding(.top, 20)
    }
}

struct ItemView: View {
    var journey: Journey
    
    @State var target: Block = Block(id: -1, content: "", isThumbnail: false)
    
    var body: some View {
        if journey.blocks.isEmpty {
            
        } else {
            NavigationLink {
                if target.id == -1 {
                    BlockView(isThumbnail: false, photo: journey.blocks[0].photo, content: journey.blocks[0].content, editedContent: journey.blocks[0].editedContent)
                } else {
                    BlockView(isThumbnail: false, photo: journey.blocks[0].photo, content: journey.blocks[0].content, editedContent: journey.blocks[0].editedContent)
                }
            } label: {
                VStack {
                    // 사진
                    
                    HStack {
                        if target.id == -1 {
                            Text(journey.blocks[0].content)
                                .font(.title)
                            Spacer()
                        } else {
                            Text(journey.blocks[0].editedContent ?? "")
                                .font(.body)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Text(String(journey.id))
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            .onAppear {
                self.target = journey.blocks.first{ $0.isThumbnail == true } ?? Block(id: -1, content: "", isThumbnail: false)
            }
        }
    }
}

