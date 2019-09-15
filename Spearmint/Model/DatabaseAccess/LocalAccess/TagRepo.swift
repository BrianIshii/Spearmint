//
//  TagRepo.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TagRepo: BaseRepo<Tag> {
    
}

extension TagRepo: TagQuery {
    func query(_ text: String) -> [Tag] {
        var tags: [Tag] = []
        let pairs = items.filter {$0.value.text.contains(text)}
        for (_, v) in pairs {
            tags.append(v)
        }
        return []
    }
}

extension TagRepo: TagRepository {
    func getAllTags() -> [Tag] {
        return getAll()
    }
}
