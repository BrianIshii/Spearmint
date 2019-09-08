//
//  Registrar.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public protocol Registrar {
    func registerSingleton<T: Any>(_ singleton: T)
    func register<T>(_ service: T.Type)
}
