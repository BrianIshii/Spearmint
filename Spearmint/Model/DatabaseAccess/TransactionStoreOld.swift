//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TransactionStoreOld {
    public var TransactionControllerNeedsUpdate = false
    public var analysisViewController = false
    public var transactions: [String: Transaction] = [:]
    public var observers: [TransactionObserver] = []
    
    init() {
        self.transactions = self.getAllTransactions()
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions[transaction.ID] = transaction
        update()
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        transactions.removeValue(forKey: transaction.ID)
        update()
    }
    
    func getTransaction(_ id: TransactionID) -> Transaction? {
        return transactions[id.id]
    }
    
    private func getAllTransactions() -> [String: Transaction] {
        if LocalAccess.reset {
            update(data: [String: Transaction]())
            return [String: Transaction]()
        }
        
        return LocalAccess.getDictionary(key: String.self, object: Transaction.self)
    }
    
    func update() {
        update(data: transactions)
        for observer in observers {
            observer.update()
        }
    }
    
    fileprivate func update(data: [String : Transaction]) {
        LocalAccess.updateDictionary(data: transactions)
        
        TransactionControllerNeedsUpdate = true
        analysisViewController = true
    }
    
    let dummyTransaction =
        Transaction(name: "test1", transactionType: TransactionType.income, vendor: Vendor(name: "APPLE").id, amount: 10.00, date: TransactionDate(), location: "N/A", image: false, notes: "notes", budgetDate: BudgetDate(Date()), items: [:])
}
