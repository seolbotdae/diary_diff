//
//  NextDayDiaryView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/15/24.
//

import SwiftUI

struct TempBlock: Identifiable {
    var id: UUID = UUID()
    var content: String = ""
}

struct NextDayDiaryView: View {
    var date: Date
    @State var tempBlocks: [TempBlock] = []
    @State var isSheetShow: Bool = false
    @State var selectedBlockId: UUID = UUID()
    
    var body: some View {
        VStack {
            List {
                ForEach(tempBlocks, id: \.id) { item in
                    Button {
                        selectedBlockId = item.id
                        isSheetShow.toggle()
                    } label: {
                        Text(item.content)
                    }
                }
            }
            
            Button {
                let tempId = UUID()
                tempBlocks.append(TempBlock(id: tempId))
                selectedBlockId = tempId
                isSheetShow.toggle()
            } label: {
                Text("블록 추가")
            }
        }
        .navigationTitle(Date.getYYYYMMDDString(date: date))
        .toolbar {
            ToolbarItem {
                Button {
                    for i in tempBlocks {
                        print(i.content)
                    }
                } label: {
                    Text("저장")
                }
            }
        }
        .sheet(isPresented: $isSheetShow) {
            AddBlockView(isSheetShow: $isSheetShow, blocks: $tempBlocks, selectedBlockId: selectedBlockId)
        }
    }
}

