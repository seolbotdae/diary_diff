////
////  CurrentDayEditSheetView.swift
////  NC1
////
////  Created by Seol WooHyeok on 4/17/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct CurrentDayEditSheetView: View {
//    @Binding var isSheetShow: Bool
//    @Binding var tempBlocks: [CurrentDayTempBlock]
//    
//    @FocusState var textEditorFocus: Bool
//    var selectedBlockId: UUID
//    
//    var journey: Journey
//    // journey 가져오려고..
//    let journeyId: Int
//    
//    @State var inputText: String = ""
//    
//    @State var isThumbnail: Bool = false
//    
//    var block: CurrentDayTempBlock = CurrentDayTempBlock(id: UUID())
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("사진 추가")
//                .font(.largeTitle)
//            
//            Text("내용 수정")
//                .font(.largeTitle)
//            
//            TextEditor(text: $inputText)
//                .onAppear {
//                    let blockIdx = tempBlocks.firstIndex { B in
//                        B.id == selectedBlockId
//                    }
//                    
//                    inputText = tempBlocks[blockIdx ?? 0].content
//                    
//                    textEditorFocus.toggle()
//                }
//                .focused($textEditorFocus)
//                .lineLimit(6)
//                .frame(height: 300)
//            
//           
//            Text("썸네일로 설정")
//                .font(.largeTitle)
//            
//            VStack {
//                Toggle(isOn: $isThumbnail, label: {
//                    VStack(alignment: .leading) {
//                        Text("이 글을 썸네일로 설정합니다.")
//                        Text("이전 썸네일은 자동 해제됩니다.")
//                            .font(.system(size: 14, weight: .light))
//                    }
//                })
//                .onAppear {
//                    let blockIdx = tempBlocks.firstIndex { B in
//                        B.id == selectedBlockId
//                    }
//                    
//                    isThumbnail = tempBlocks[blockIdx ?? 0].isThumbnail
//                    
//                    
//                }
//            }
//            
//            Spacer()
//        }
//        .navigationTitle("내용 입력")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button {
//                    let idx = tempBlocks.firstIndex { T in
//                        T.id == selectedBlockId
//                    }
//                    
//                    if let target = idx {
//                        if tempBlocks[target].content == "" {
//                            tempBlocks.remove(at: target)
//                        }
//                    }
//                    
//                    isSheetShow.toggle()
//                } label: {
//                    Text("취소")
//                }
//            }
//            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    if isThumbnail == true {
//                        print("썸네일 ")
//                        
//                        let thumbnailIdx = tempBlocks.firstIndex { B in
//                            B.isThumbnail == true
//                        }
//                        
//                        if let idx = thumbnailIdx {
//                            tempBlocks[idx].isThumbnail = false
//                        }
//                    }
//                   
//                    
//                    let blockIdx = tempBlocks.firstIndex { B in
//                        B.id == selectedBlockId
//                    }
//                    
//                    if let idx = blockIdx {
//                        tempBlocks[blockIdx ?? 0].content = inputText
//                        tempBlocks[blockIdx ?? 0].isThumbnail = isThumbnail
//                    }
//                    
//                    let idx = tempBlocks.firstIndex { T in
//                        T.id == selectedBlockId
//                    }
//                    
//                    if let target = idx {
//                        if tempBlocks[target].content == "" {
//                            tempBlocks.remove(at: target)
//                        }
//                    }
//                    
//                    isSheetShow.toggle()
//                } label: {
//                    Text("변경")
//                }
//            }
//        }
//        .interactiveDismissDisabled()
//    }
//}
