//
//  Tag.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Tag: Saveable {
    var text: String
    var color: Color
    
    init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
}
