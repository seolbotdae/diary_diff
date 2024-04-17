//
//  DummyBlock.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/18/24.
//

import Foundation


final class DummyBlock {
    var id: UUID
    
    // 임시로 String 해둔것
    var photo: String?

    var content: String
    var editedContent: String?
    
    var order: Int = 0
    
    var isThumbnail: Bool = false
    
    init(id: UUID, photo: String? = nil, content: String, editedContent: String? = nil, order: Int, isThumbnail: Bool) {
        self.id = id
        self.photo = photo
        self.content = content
        self.editedContent = editedContent
        self.order = order
        self.isThumbnail = isThumbnail
    }
}
