//
//  Resolver.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T?
}
