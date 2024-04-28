//
//  Journey.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import Foundation
import SwiftData

@Model
final class Journey {
    /// Date 가 2024/01/01 일인 경우, 시간에 상관없이 ParsedDate는 20240101 형태를 띄는 Int 타입입니다.
    typealias ParsedDate = Int
    
    @Attribute(.unique) var id: ParsedDate
    @Relationship(deleteRule: .cascade, inverse: \Block.journey) var blocks: [Block]?
    var thumbnail: Block?
  
    init(id: ParsedDate, blocks: [Block]? = nil, thumbnail: Block? = nil) {
        self.id = id
        self.blocks = blocks
        self.thumbnail = thumbnail
    }
}
