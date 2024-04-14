//
//  Item.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/13/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
