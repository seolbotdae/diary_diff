//
//  TodayEditView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/18/24.
//

import SwiftUI

struct TodayEditView: View {
    var selectedBlockId: Int
    
    @Binding var blocks: [DummyBlock]
    
    @State var photoTestText: String = ""
    
    @State var prevContent: String = ""
    @State var currentContent: String = ""
    
    @State var ThumbnailToggle: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("사진 추가")
                .font(.title)
            
            TextField("사진 임시", text: $photoTestText)
                .font(.title)
            
            Text("내용 수정")
                .font(.title2)
            
            Text(prevContent)
            
            TextEditor(text: $currentContent)
                .onAppear {
                    // 만약, 블럭 내부에 이전 내용이 적혀 있다면 변경해야함.
                    if let target = blocks.first(where: { $0.id == selectedBlockId}) {
                        currentContent = target.content
                    }
                }
            
            Toggle(isOn: $ThumbnailToggle) {
                VStack(alignment: .leading) {
                    Text("이 글을 썸네일로 설정하겠소")
                    Text("이전 썸네일은 자동으로 해제됩니다.")
                }
            }
            .onAppear {
                // 만약, 블럭 내부에 이전 내용이 적혀 있다면 변경해야함.
                if let target = blocks.first(where: { $0.id == selectedBlockId}) {
                    ThumbnailToggle = target.isThumbnail
                }
            }
        }
        .navigationTitle("내용 입력")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveTodayBlock()
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
                prevContent = target.content
                currentContent = target.editedContent ?? ""
            }
        }

    }
    
    func saveTodayBlock() {
        // 이미 있는 블록 (변경해야함)
        if let targetIdx = blocks.firstIndex(where: {$0.id == selectedBlockId}) {
            print("이미 있는 블록")
            print(targetIdx)
            // 수정했는데 내용이 없다
            if currentContent.trimmingCharacters(in: .whitespacesAndNewlines) == "" && photoTestText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                blocks.remove(at: targetIdx)
            } else {
                // thumbnail 지정 -> 다 털어내고 썸네일로 만들기
                if ThumbnailToggle == true {
                    for i in blocks {
                        i.isThumbnail = false
                    }
                }
                blocks[targetIdx] = DummyBlock(id: selectedBlockId, photo: photoTestText, content: prevContent, editedContent: currentContent, isThumbnail: ThumbnailToggle)
            }
        } else {
            // 새로 추가합니다.
            // 혹시 장난질을 했다면(빈칸이면) 곧장 지워버립니다. (추가를 하지 않는다.)
            if currentContent.trimmingCharacters(in: .whitespacesAndNewlines) == "" && photoTestText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            } else {
                // thumbnail 지정 -> 다 털어내고 썸네일로 만들기
                if ThumbnailToggle == true {
                    for i in blocks {
                        i.isThumbnail = false
                    }
                }
                // 새 글 추가를 뜻합니다.
                if selectedBlockId == -1 {
                    blocks.append(DummyBlock(id: blocks.count, photo: photoTestText, content: "", editedContent: currentContent, isThumbnail: ThumbnailToggle))
                }
            }
        }
    }
}
