//
//  Assembler.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

enum ContainerError: Error {
    case NotFoundError(service: String)
}

public class Container : Registrar, Resolver {
    fileprivate var items: [String: Any]
    
    public init() {
        self.items = [:]
    }
    
    public func registerSingleton<T>(_ singleton: T) {
        items["\(T.self)"] = singleton
    }
    
    public func register<T>(_ service: T.Type) {
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        if let item = items["\(T.self)"] {
            return item as? T
        }
        return nil
    }
}
