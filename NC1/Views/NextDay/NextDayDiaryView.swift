//
//  NextDayDiaryView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/15/24.
//

import SwiftUI
import SwiftData

// 앱 내부에서 사용할 블럭
struct TempBlock: Identifiable {
    var id: UUID = UUID()
    var content: String = ""
}

struct NextDayDiaryView: View {
    // 외부에서 받아온 journey
    var journey: Journey

    @State var tempBlocks: [TempBlock] = []

    @State var selectedTempBlockId: UUID = UUID()
    
    @State var draggedBlock: TempBlock?
    
    @State var orderCount: Int = 0
    
    @State var isSheetShow: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(tempBlocks) { item in
                    Button {
                        selectedTempBlockId = item.id
                        isSheetShow.toggle()
                    } label: {
                        Text(item.content)
                            .foregroundStyle(.white)
                    }
                }
            }
            
            
            /// 블록이 추가되고, sheet가 올라오고, 즉시 textEditor에 focus가 걸립니다.
            Button {
                let tempId = UUID()
                tempBlocks.append(TempBlock(id: tempId))
                orderCount += 1
                selectedTempBlockId = tempId
                isSheetShow.toggle()
            } label: {
                Text("블록 추가")
            }
        }
        .navigationTitle(String(journey.id))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem {
                /// 버튼을 누르면, 지금까지 만들어낸 리스트에 번호를 붙여서 SwiftData에 저장합니다.
                Button {
                    var orderCount = 0
                    
                    for i in tempBlocks {
                        _ = Block(id: i.id, journey: journey, photo: "", prevContent: i.content, order: orderCount)
                        orderCount += 1
                    }
                    
                    print("저장 완료")
                } label: {
                    Text("저장")
                }
            }
        }
        .sheet(isPresented: $isSheetShow) {
            NextDayBlockSheetView(isSheetShow: $isSheetShow, blocks: $tempBlocks, selectedBlockId: selectedTempBlockId)
        }
        .onAppear {
            /// 만약 SwiftData의 해당 journey에 block이 있다면, order순서대로 정렬시켜서 리스트롤 보여줍니다.
            /// 사전에 정리를 해두는 것.
            for block in journey.blocks.sorted(by: { lhs, rhs in
                lhs.order < rhs.order
            }) {
                let newItem = TempBlock(id: block.id, content: block.prevContent ?? "")
                tempBlocks.append(newItem)
            }
        }
    }
}

