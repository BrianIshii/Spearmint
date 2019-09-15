//
//  BudgetInfastructure.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/15/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public class BudgetInfastructure {
    public static func initialize(_ registrar: Registrar,_ resolver: Resolver) {
        registrar.registerSingleton(DateFormatterFactory())
    }
}
