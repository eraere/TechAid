//
//  Item.swift
//  TechAid
//
//  Created by Era Aliu on 29.1.25.
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
