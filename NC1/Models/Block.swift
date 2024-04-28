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
    /// 0 부터 시작하는 Int 타입입니다. 순서를 나타냅니다.
    typealias Order = Int
    
    var id: UUID
    var journey: Journey
    var photo: Data?

    var content: String
    var editedContent: String?
    
    var order: Order
    
    init(id: UUID, journey: Journey, photo: Data? = nil, content: String, editedContent: String? = nil, order: Order) {
        self.id = id
        self.journey = journey
        self.photo = photo
        self.content = content
        self.editedContent = editedContent
        self.order = order
    }
}
