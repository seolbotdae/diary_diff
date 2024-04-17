//
//  CurrentDayDiaryView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/17/24.
//

import SwiftUI

// 앱 내부에서 사용할 블럭
struct CurrentDayTempBlock: Identifiable {
    var id: UUID = UUID()
    var isThumbnail: Bool = false
    
    // 반드시 원본은 있어야 함.
    var content: String = ""
    
    var photo: String? 
    
    var editedContent: String?
}

struct CurrentDayDiaryView: View {
    // 외부에서 받아온 journeyDate
    let journeyDate: Date
    
    // 내부에서 설정됨
    let journeyId: Int
    let formattedDate: String

    @State var tempBlocks: [CurrentDayTempBlock] = []

    @State var selectedTempBlockId: UUID = UUID()
    
    @State var orderCount: Int = 0
    
    @State var isSheetShow: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(tempBlocks) { item in
                    Section {
                        BlockView(isThumbnail: false, photo: nil, prevContent: item.content, editedContent: nil)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            selectedTempBlockId = item.id
                            isSheetShow.toggle()
                        } label: {
                            Text("수정")
                                .fontWeight(.ultraLight)
                        }
                        .tint(.indigo)
                    }
                    .listSectionSpacing(12)
                }
                .onDelete { idxSet in
                    tempBlocks.remove(atOffsets: idxSet)
                }
            }
            .padding(.top, 10)
            
            
            
            
            /// 블록이 추가되고, sheet가 올라오고, 즉시 textEditor에 focus가 걸립니다.
            Button {
                let tempId = UUID()
                tempBlocks.append(CurrentDayTempBlock(id: tempId))
                orderCount += 1
                selectedTempBlockId = tempId
                isSheetShow.toggle()
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                    
                    Image(systemName: "plus")
                    Text("블록 추가")
                    
                    Spacer()
                }
                .padding(10)
                .frame(width: 361, height: 60, alignment: .center)
                .background(Color(red: 0.37, green: 0.36, blue: 0.9))
                .cornerRadius(16)
                .foregroundStyle(.white)
            }
        }
        .navigationTitle(formattedDate)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem {
                /// 버튼을 누르면, 지금까지 만들어낸 리스트에 번호를 붙여서 SwiftData에 저장합니다.
                Button {
                    let target = Journey(id: journeyId, blocks: [])
                    modelContext.insert(target)
                    
                    var orderCount = 0
                    
                    for i in tempBlocks {
                        target.blocks.append(Block(id: i.id, content: i.content, order: orderCount, isThumbnail: false))
                        orderCount += 1
                    }
                    modelContext.insert(target)
                    print("저장 완료")
                } label: {
                    Text("저장")
                }
                .disabled({tempBlocks.count == 0}())
            }
        }
        .sheet(isPresented: $isSheetShow) {
            NavigationStack {
            }
        }
        .onAppear {
        }
    }
}

