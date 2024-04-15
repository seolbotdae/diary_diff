//
//  AddBlockView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/15/24.
//

import SwiftUI

struct AddBlockView: View {
    @Binding var isSheetShow: Bool
    @Binding var blocks: [TempBlock]
    var selectedBlockId: UUID
    
    @State var inputText: String = ""
    
    var block: TempBlock = TempBlock(id: UUID())
    
    var body: some View {
        Text("내용을 입력해보시오")
            .font(.title)
        
        TextEditor(text: $inputText)
            .onAppear {
                let blockIdx = blocks.firstIndex { B in
                    B.id == selectedBlockId
                }
                
                inputText = blocks[blockIdx ?? 0].content
            }
        
        Button {
            let blockIdx = blocks.firstIndex { B in
                B.id == selectedBlockId
            }
            
            blocks[blockIdx ?? 0].content = inputText
            
            isSheetShow.toggle()
        } label: {
            Text("저장")
        }
    }

}
