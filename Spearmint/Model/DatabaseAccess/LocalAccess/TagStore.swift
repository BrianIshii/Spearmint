//
//  TagStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TagStore: BaseRepo<Tag> {
    
}

extension TagStore {
    func query(_ text: String) -> [Tag] {
        var tags: [Tag] = []
        let pairs = items.filter {$0.value.text.contains(text)}
        for (_, v) in pairs {
            tags.append(v)
        }
        return []
    }
}
