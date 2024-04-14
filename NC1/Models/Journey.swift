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
    var timestamp: Date
    
    var blocks: [Block]
    
    var thumbnail: Block
    
    init(timestamp: Date, blocks: [Block], thumbnail: Block) {
        self.timestamp = timestamp
        self.blocks = blocks
        self.thumbnail = thumbnail
    }
}
