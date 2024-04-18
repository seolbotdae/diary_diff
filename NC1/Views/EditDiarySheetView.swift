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
    
    @Binding var isSheetShow: Bool
    @Binding var blocks: [DummyBlock]
    
    // 자동 포커스를 걸기 위한 변수
    @FocusState var textEditorFocus: Bool
    
    // ForEach 버그를 피하기 위한 선택된 블럭의 Id
    var selectedBlockId: Int
    
    @State var photoTestText: String = ""
    
    @State var textFieldInput: String = ""
    
    @State var ThumbnailToggle: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
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
                
            case .today:
                VStack {
                    Text("사진 추가")
                        .font(.title)
                    
                    TextField("사진 임시", text: $photoTestText)
                        .font(.title)
                    
                    Text("내용 수정")
                        .font(.title2)
                    
                    TextEditor(text: $textFieldInput)
                        .onAppear {
                            textEditorFocus.toggle()
                        }
                        .focused($textEditorFocus)
                    
                    Toggle(isOn: $ThumbnailToggle) {
                        VStack(alignment: .leading) {
                            Text("이 글을 썸네일로 설정하겠소")
                            Text("이전 썸네일은 자동으로 해제됩니다.")
                        }
                    }
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
        
        isSheetShow.toggle()
    }
    
    func saveTodayBlock() {
        // 이미 있는 블록 (변경해야함)
        if let targetIdx = blocks.firstIndex(where: {$0.id == selectedBlockId}) {
            blocks[targetIdx] = DummyBlock(id: selectedBlockId, content: textFieldInput, isThumbnail: false)
        } else {
            // 새로 추가합니다.
            // 혹시 장난질을 했다면(빈칸이면) 곧장 지워버립니다. (추가를 하지 않는다.)
            if textFieldInput.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            } else {
                
                /// 1. textFieldInput을 안 적은 경우는 확실하게 error
                blocks.append(DummyBlock(id: blocks.count, photo: photoTestText, content: textFieldInput, editedContent: textFieldInput, isThumbnail: false))
            }
        }
        
        isSheetShow.toggle()
    }
}
