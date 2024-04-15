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
    @Attribute(.unique)
    var id: UUID
    // 소속 journey
    @Relationship(inverse: \Journey.blocks)
    var journey: Journey?
    // 임시로 String 해둔것
    var photo: String?

    var prevContent: String?
    var currentContent: String?
    
    var order: Int = 0
    
    init(id: UUID, journey: Journey? = nil, photo: String? = nil, prevContent: String? = nil, currentContent: String? = nil, order: Int) {
        self.id = id
        self.journey = journey
        self.photo = photo
        self.prevContent = prevContent
        self.currentContent = currentContent
        self.order = order
    }
}
