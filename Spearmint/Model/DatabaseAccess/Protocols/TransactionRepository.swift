//
//  TransactionRepository.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/9/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol TransactionRepository {
    func getAllTransactions() -> [Transaction]
    func get(_ id: TransactionID) -> Transaction?
    func append(_ transaction: Transaction)
    func update(_ transaction: Transaction)
    func remove(_ transaction: Transaction)
    func addTransactionObserver(_ observer: TransactionObserver)
}
