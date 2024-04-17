//
//  Block.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import Foundation
import SwiftData

@Model
final class Block {
    var id: Int
    // 소속 journey
    @Relationship(inverse: \Journey.blocks)
    var journey: Journey?
    // 임시로 String 해둔것
    var photo: String?

    var content: String
    var editedContent: String?
    
    var isThumbnail: Bool = false
    
    init(id: Int, journey: Journey? = nil, photo: String? = nil, content: String, editedContent: String? = nil, isThumbnail: Bool) {
        self.id = id
        self.journey = journey
        self.photo = photo
        self.content = content
        self.editedContent = editedContent
        self.isThumbnail = isThumbnail
    }
}
