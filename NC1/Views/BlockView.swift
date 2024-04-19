//
//  BlockView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/16/24.
//

import SwiftUI

struct BlockView: View {
    var isThumbnail: Bool = false
    
    // 임시로 String? 로 해둠
    var photo: String?
    var content: String?
    var editedContent: String?
    
    var body: some View {
        /// content 만 있고, editedContent, photo 가 없다 -> 일반 블럭
        /// content 있고 editedContent 있고 photo가 없다 . -> 사진없는 수정블럭
        /// content 있고 editedContent 없고 photo가 있다. -> 사진있는 일반블럭
        /// 다 있다. -> 사진있는 수정블럭
        ///
        /// edited 있다 -> 수정블럭이 된다.
        /// photo 있다 -> photo 넣는다.
    
        VStack(alignment: .leading) {
            if isThumbnail {
                HStack {
                    Text("썸네일로 설정됨")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.46, green: 0.45, blue: 0.9))
                    
                    Spacer()
                }
            }
            
            if photo != nil {
                VStack {
                    Text("photo enable")
                }
            }
            
            if let edited = editedContent {
                if edited != "" {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(content!)

                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .foregroundStyle(.white)
                        .background(Color(red: 0.31, green: 0.39, blue: 0.69))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.down")
                            Spacer()
                        }
                        
                        HStack {
                            Text(edited)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .foregroundStyle(.white)
                        .background(Color(red: 0.37, green: 0.36, blue: 0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                    }
                }
                else {
                    Text(content!)
                }
            } else {
                VStack(alignment: .leading) {
                    Text(content!)
                }
            }
        }
    }
}

#Preview {
    BlockView(isThumbnail: true, photo: "")
}
