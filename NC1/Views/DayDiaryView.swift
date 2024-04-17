//
//  DayDiaryView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/18/24.
//

import SwiftUI
import SwiftData

struct DayDiaryView: View {
    // 외부에서 받아온 journey
    let journeyDate: Date
    let journeyId: Int
    let formattedDate: String
    
    // 임시로 사용할 Blocks
    @State var dummyBlocks: [DummyBlock] = []

    let dummyBlockId: UUID = UUID()
    
    @State var selectedBlockId: UUID = UUID()
    
    @State var orderCount: Int = 1
    
    @State var isSheetShow: Bool = false
    
    @Environment(\.modelContext) var modelContext
    
    @Query var journey: [Journey]
    
    var body: some View {
        VStack {
            List {
                ForEach(dummyBlocks, id: \.id) { item in
                    Section {
                        BlockView(isThumbnail: false, photo: nil, prevContent: item.content, editedContent: nil)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            selectedBlockId = item.id
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
                    dummyBlocks.remove(atOffsets: idxSet)
                }
            }
            .padding(.top, 10)
            
            /// 블록이 추가되고, sheet가 올라오고, 즉시 textEditor에 focus가 걸립니다.
            Button {
                // 블록 추가라는 것을 확실하게 하기 위함
                selectedBlockId = dummyBlockId
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
                Button {
                   save()
                } label: {
                    Text("저장")
                }
                .disabled({dummyBlocks.count == 0}())
            }
        }
        .sheet(isPresented: $isSheetShow) {
            NavigationStack {
                EditDiarySheetView(type: .tomorrow, isSheetShow: $isSheetShow, blocks: $dummyBlocks, selectedBlockId: selectedBlockId)
            }
        }
        .onAppear {
            load()
        }
    }
    
    init(journeyDate: Date) {
        self.journeyDate = journeyDate
        
        self.journeyId = Date.getDateId(date: journeyDate)
        self.formattedDate = Date.getYYYYMMDDString(date: journeyDate)
        
        /// journeyId에 맞는 날짜로 Journey를 쿼리함
        /// 오류가 아닌 경우 하나만 나옴
        let journeyPredicate = #Predicate<Journey> { J in
            J.id == journeyId
        }
        _journey = Query(filter: journeyPredicate)
    }
    
    // 버튼을 누르면, 지금까지 만들어낸 리스트에 번호를 붙여서 SwiftData에 저장합니다.
    func save() {
        if !journey.isEmpty {
            var orderCount = 1
            
            var array: [Block] = []
            
            for i in dummyBlocks {
                let block = Block(id: i.id, journey: journey[0], photo: "", content: i.content, order: orderCount, isThumbnail: false)
                
                array.append(block)
                
                orderCount += 1
            }
            
            journey[0].blocks = array
            
            modelContext.insert(journey[0])
        }
        
        print("저장 완료")
    }
    
    func load() {
        // 만약 SwiftData의 해당 journey에 block이 있다면, order순서대로 정렬시켜서 리스트롤 보여줍니다.
        // 사전에 정리를 해두는 것.
        if !journey.isEmpty {
            let target = journey[0]
            
            // 블럭이 있다!
            if !target.blocks.isEmpty {
                for block in target.blocks.sorted(by: { lhs, rhs in
                    lhs.order < rhs.order
                }) {
                    let newItem = DummyBlock(id: block.id, photo: block.photo, content: block.content, editedContent: block.editedContent, order: block.order, isThumbnail: block.isThumbnail)
                    
                    dummyBlocks.append(newItem)
                }
            }
        }
        
    }
}
