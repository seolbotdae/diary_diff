//
//  TomorrowEditView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/18/24.
//

import SwiftUI
import SwiftData

struct TomorrowEditView: View {
    // ForEach 버그를 피하기 위한 선택된 블럭의 Id
    var selectedBlockId: Int
    
    @Binding var blocks: [DummyBlock]
    
    @State var textFieldInput: String = ""
    
    // 자동 포커스를 걸기 위한 변수
    @FocusState var textEditorFocus: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveTomorrowBlock()
                    dismiss()
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
    }
    
    func saveTomorrowBlock() {
        // 이미 있는 블록 (변경해야함)
        if let targetIdx = blocks.firstIndex(where: {$0.id == selectedBlockId}) {
            
            // 혹시 장난질을 했다면(빈칸이면) 곧장 지워버립니다.
            if textFieldInput.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                blocks.remove(at: targetIdx)
            } else {
                blocks[targetIdx] = DummyBlock(id: selectedBlockId, content: textFieldInput, isThumbnail: false)
            }
        } else {
            // 새로 추가합니다.
            // 혹시 장난질을 했다면(빈칸이면) 곧장 지워버립니다. (추가를 하지 않는다.)
            if textFieldInput.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            } else {
                blocks.append(DummyBlock(id: blocks.count, content: textFieldInput, isThumbnail: false))
            }
        }
    }
    
}
