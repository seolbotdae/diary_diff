//
//  EditDiarySheetView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/18/24.
//

import SwiftUI

struct EditDiarySheetView: View {
    enum SheetType {
        case tomorrow
        case today
    }
    
    var type: SheetType
    
    // 추가면 +1 해서 줘야겠고 아니면 클릭된 친구의 order를.. 내가 해줘야함
    var order: Int
    
    @Binding var isSheetShow: Bool
    @Binding var blocks: [DummyBlock]
    
    // 자동 포커스를 걸기 위한 변수
    @FocusState var textEditorFocus: Bool
    
    // ForEach 버그를 피하기 위한 선택된 블럭의 Id
    var selectedBlockId: UUID
    
    @State var textFieldInput: String = ""
    
    var block: NextDayTempBlock = NextDayTempBlock(id: UUID())
    
    var body: some View {
        switch type {
        case .tomorrow:
            VStack {
                TextEditor(text: $textFieldInput)
                    .onAppear {
                        textEditorFocus.toggle()
                    }
                    .focused($textEditorFocus)
            }
            .navigationTitle("내용 입력")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isSheetShow.toggle()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveTomorrowBlock()
                    } label: {
                        Text("저장")
                    }
                }
            }
            .interactiveDismissDisabled()
            .onAppear {
                // 만약, 블럭 내부에 이전 내용이 적혀 있다면 변경해야함.
                if let target = blocks.first(where: { $0.id == selectedBlockId}) {
                    textFieldInput = target.content
                }
            }
            
        case .today:
            VStack {
                TextEditor(text: $textFieldInput)
                    .onAppear {
                        let blockIdx = blocks.firstIndex { B in
                            B.id == selectedBlockId
                        }
                        
                        textFieldInput = blocks[blockIdx ?? 0].content
                        
                        textEditorFocus.toggle()
                    }
                    .focused($textEditorFocus)
            }
            .navigationTitle("내용 입력")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        let idx = blocks.firstIndex { T in
                            T.id == selectedBlockId
                        }
                        
                        if let target = idx {
                            if blocks[target].content == "" {
                                blocks.remove(at: target)
                            }
                        }
                        
                        isSheetShow.toggle()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let blockIdx = blocks.firstIndex { B in
                            B.id == selectedBlockId
                        }
                        
                        blocks[blockIdx ?? 0].content = textFieldInput
                        
                        let idx = blocks.firstIndex { T in
                            T.id == selectedBlockId
                        }
                        
                        if let target = idx {
                            if blocks[target].content == "" {
                                blocks.remove(at: target)
                            }
                        }
                        
                        isSheetShow.toggle()
                    } label: {
                        Text("저장")
                    }
                }
            }
            .interactiveDismissDisabled()
        }
    }
    
    func saveTomorrowBlock() {
        // 이미 있는 블록 (변경해야함)
        if let targetIdx = blocks.firstIndex(where: {$0.id == selectedBlockId}) {
            
            // 혹시 장난질을 했다면(빈칸이면) 곧장 지워버립니다.
            if textFieldInput.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                blocks.remove(at: targetIdx)
            } else {
                blocks[targetIdx] = DummyBlock(id: selectedBlockId, content: textFieldInput, order: order, isThumbnail: false)
            }
        } else {
            // 새로 추가합니다.
            // 혹시 장난질을 했다면(빈칸이면) 곧장 지워버립니다.
            if textFieldInput.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            } else {
                blocks.append(DummyBlock(id: UUID(), content: textFieldInput, order: order + 1, isThumbnail: false))
            }
        }
        
        isSheetShow.toggle()
    }
}
