//
//  AddBlockView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/15/24.
//

import SwiftUI

struct NextDayEditSheetView: View {
    @Binding var isSheetShow: Bool
    @Binding var blocks: [NextDayTempBlock]
    @FocusState var textEditorFocus: Bool
    var selectedBlockId: UUID
    
    @State var inputText: String = ""
    
    var block: NextDayTempBlock = NextDayTempBlock(id: UUID())
    
    var body: some View {
        VStack {
            TextEditor(text: $inputText)
                .onAppear {
                    let blockIdx = blocks.firstIndex { B in
                        B.id == selectedBlockId
                    }
                    
                    inputText = blocks[blockIdx ?? 0].content
                    
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
                    
                    blocks[blockIdx ?? 0].content = inputText
                    
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
