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
    @Attribute(.unique)
    var id: Int
    
    @Relationship
    var blocks: [Block] = []
    
    var thumbnail: Block?
  
    init(id: Int, blocks: [Block], thumbnail: Block? = nil) {
        self.id = id
        self.blocks = blocks
        self.thumbnail = thumbnail
    }
}
