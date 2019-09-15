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
        let budgetRepository = BudgetStore(localPersistanceService: localPersistanceService)
        let budgetItemRepository = BudgetItemStore(localPersistanceService: localPersistanceService)
        let vendorRepository = VendorStore(localPersistanceService: localPersistanceService)
        let tagRepository = TagRepo(localPersistanceService: localPersistanceService)
        let transactionStore = TransactionStore(localPersistanceService: localPersistanceService)
        
        registrar.registerSingleton(localPersistanceService)
        registrar.registerSingleton(budgetRepository as BudgetRepository)
        registrar.registerSingleton(budgetItemRepository as BudgetItemRepository)
        registrar.registerSingleton(vendorRepository as VendorRepository)
        registrar.registerSingleton(transactionStore as TransactionRepository)
        registrar.registerSingleton(tagRepository as TagRepository)
        registrar.registerSingleton(tagRepository as TagQuery)
    }
}
