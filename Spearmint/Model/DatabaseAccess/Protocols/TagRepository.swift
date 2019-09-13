//
//  TagRepository.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol TagRepository {
    func append(_ tag: Tag)
    func get(_ tagID: TagID) -> Tag?
    func getAllTags() -> [Tag] 
}
