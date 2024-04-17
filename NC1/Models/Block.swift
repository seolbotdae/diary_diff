//
//  Block.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import Foundation

@Observable
class Block {
    var id: UUID
    
    var journey: Journey?
    var photo: String?

    var content: String
    var editedContent: String?
    
    var order: Int = 0
    
    var isThumbnail: Bool = false
    
    init(id: UUID, journey: Journey? = nil, photo: String? = nil, content: String, editedContent: String? = nil, order: Int, isThumbnail: Bool) {
        self.id = id
        self.journey = journey
        self.photo = photo
        self.content = content
        self.editedContent = editedContent
        self.order = order
        self.isThumbnail = isThumbnail
    }
}
