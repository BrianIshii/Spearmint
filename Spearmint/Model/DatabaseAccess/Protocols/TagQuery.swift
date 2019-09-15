//
//  TagQuery.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/15/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol TagQuery {
    func query(_ substring: String) -> [Tag] 
}
