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
    var prevContent: String?
    var editedContent: String?
    
    var body: some View {
        VStack {
            if isThumbnail {
                HStack {
                    Text("썸네일로 설정됨")
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                }
            }
            
            if let photo = photo {
                VStack {
                    Text("photo enable")
                }
            }
            
            // both exist
            if let prev = prevContent, let edited = editedContent {
                VStack {
                    Text(prev)
                    Image(systemName: "arrow.down")
                    Text(edited)
                }
            } else if let prev = prevContent {
                VStack {
                    Text(prev)
                }
            }
            
        }
    }
}

#Preview {
    BlockView(isThumbnail: true, photo: "")
}
