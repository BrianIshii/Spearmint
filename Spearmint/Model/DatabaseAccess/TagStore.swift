//
//  TagStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TagStore {
    fileprivate var tagDictionary: [String: Tag] = [:]
    
    init() {
        self.tagDictionary = getTagDictionary()
    }
    
    public func hasTag(_ text: String) -> Bool {
        return tagDictionary.keys.contains(text)
    }
    
    public func getTag(_ text: String) -> Tag? {
        return tagDictionary[text] ?? nil
    }
    
    public func addTag(_ tag: Tag) {
        tagDictionary[tag.text] = tag
        updateTagDictionary()
    }
    
    public func update() {
        updateTagDictionary()
    }
    
    public func query(_ substring: String) -> [Tag] {
        var tags: [Tag] = []
        let pairs = tagDictionary.filter {$0.value.text.contains(substring)}
        for (_, v) in pairs {
            tags.append(v)
        }
        return tags
    }
    
    fileprivate func getTagDictionary() -> [String: Tag] {
        return LocalAccess.getDictionary(key: String.self, object: Tag.self)
    }
    
    fileprivate func updateTagDictionary() {
        LocalAccess.updateDictionary(data: tagDictionary)
    }
}
