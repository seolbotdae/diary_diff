//
//  DummyBlock.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/18/24.
//

import Foundation


final class DummyBlock: Identifiable {
    var uuid: UUID = UUID()
    var id: Int
    
    // 임시로 String 해둔것
    var photo: String?

    var content: String
    var editedContent: String?
    
    var isThumbnail: Bool = false
    
    init(id: Int, photo: String? = nil, content: String, editedContent: String? = nil, isThumbnail: Bool) {
        self.id = id
        self.photo = photo
        self.content = content
        self.editedContent = editedContent
        self.isThumbnail = isThumbnail
    }
}
