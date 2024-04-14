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
    var journey: Journey?
    
    // 임시로 String 해둔것
    var photo: String?
    
    var prevContent: String?
    var currentContent: String?
    
    var isThumbnail: Bool
    
    init(journey: Journey? = nil, photo: String? = nil, prevContent: String? = nil, currentContent: String? = nil) {
        self.journey = journey
        self.photo = photo
        self.prevContent = prevContent
        self.currentContent = currentContent
        self.isThumbnail = false
    }
}
