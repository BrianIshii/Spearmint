//
//  DatabaseInfastructure.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/9/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class DatabaseInfastructure {
    public static func initialize(_ registrar: Registrar,_ resolver: Resolver) {
        let localPersistanceService = LocalPersistanceService()
        let localAccess = LocalAccess(localPersistanceService: localPersistanceService)
        registrar.registerSingleton(localPersistanceService)
        registrar.registerSingleton(localAccess as BudgetRepository)
        registrar.registerSingleton(localAccess as BudgetItemRepository)
        registrar.registerSingleton(localAccess as VendorRepository)
        registrar.registerSingleton(localAccess as TransactionRepository)
        registrar.registerSingleton(localAccess as TagRepository)
    }
}
