//
//  Journey.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import Foundation

@Observable
class Journey {
    var id: Int
    var blocks: [Block] = []
    
    var thumbnail: Block?
  
    init(id: Int, blocks: [Block], thumbnail: Block? = nil) {
        self.id = id
        self.blocks = blocks
        self.thumbnail = thumbnail
    }
}
