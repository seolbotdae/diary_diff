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
    let journeyDate: Date
    let journeyId: Int
    let formattedDate: String

    @State var tempBlocks: [TempBlock] = []

    @State var selectedTempBlockId: UUID = UUID()
    
    @State var draggedBlock: TempBlock?
    
    @State var orderCount: Int = 0
    
    @State var isSheetShow: Bool = false
    
    @Environment(\.modelContext) var modelContext
    
    @Query var journey: [Journey]
    
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
                tempBlocks.append(TempBlock(id: tempId))
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
                        _ = Block(id: i.id, journey: target, photo: "", prevContent: i.content, order: orderCount)
                        orderCount += 1
                    }
                    
                    print("저장 완료")
                } label: {
                    Text("저장")
                }
                .disabled({tempBlocks.count == 0}())
            }
        }
        .sheet(isPresented: $isSheetShow) {
            NavigationStack {
                NextDayEditSheetView(isSheetShow: $isSheetShow, blocks: $tempBlocks, selectedBlockId: selectedTempBlockId)
            }
        }
        .onAppear {
            /// 만약 SwiftData의 해당 journey에 block이 있다면, order순서대로 정렬시켜서 리스트롤 보여줍니다.
            /// 사전에 정리를 해두는 것.
            if journey.count >= 1 {
                for block in journey[0].blocks.sorted(by: { lhs, rhs in
                    lhs.order < rhs.order
                }) {
                    let newItem = TempBlock(id: block.id, content: block.prevContent ?? "")
                    tempBlocks.append(newItem)
                }
            }
        }
    }
    
    init(journeyDate: Date) {
        self.journeyDate = journeyDate
        self.journeyId = Date.getDateId(date: journeyDate)
        self.formattedDate = Date.getYYYYMMDDString(date: journeyDate)
        
        print(self.journeyDate)
        print(self.journeyId)
        print(self.formattedDate)
        
        /// 내일 일기에 맞는 날짜로 Journey를 쿼리함
        /// 오류가 아닌 경우 하나만 나옴
        let nextDateId = Date.getDateId(date: Date() + 86400)
        let nextDatePredicate = #Predicate<Journey> { J in
            J.id == nextDateId
        }
        _journey = Query(filter: nextDatePredicate)
    }
}

