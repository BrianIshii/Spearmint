//
//  Tag.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Tag: Saveable {
    let id: TagID
    var text: String
    var color: Color
    var transactionIDs: [TransactionID]
    
    init(id: TagID, text: String, color: Color, transactionIDs: [TransactionID]) {
        self.id = TagID(text)
        self.text = text
        self.color = color
        self.transactionIDs = transactionIDs
    }
    
    init(text: String, color: Color, transactionIDs: [TransactionID]) {
        self.id = TagID(text)
        self.text = text
        self.color = color
        self.transactionIDs = transactionIDs
    }
    
    init(text: String, color: Color) {
        self.id = TagID(text)
        self.text = text
        self.color = color
        self.transactionIDs = []
    }
}
