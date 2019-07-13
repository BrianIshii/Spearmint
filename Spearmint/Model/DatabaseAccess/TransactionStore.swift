//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TransactionStore {
    public static var TransactionControllerNeedsUpdate = false
    public static var analysisViewController = false
    public static var transactions: [String: Transaction] = getAllTransactions()
    public static var observers: [TransactionObserver] = []
    
    static func addTransaction(_ transaction: Transaction) {
        transactions[transaction.id.description()] = transaction
        update()
    }
    
    static func deleteTransaction(_ transaction: Transaction) {
        transactions.removeValue(forKey: transaction.id.description())
        update()
    }
    
    static func getTransaction(_ id: TransactionID) -> Transaction? {
        return transactions[id.description()]
    }
    private static func getAllTransactions() -> [String: Transaction] {        
        if LocalAccess.reset {
            update(data: [String: Transaction]())
            return [String: Transaction]()
        }
        
        return LocalAccess.getDictionary(key: String.self, object: Transaction.self)
    }
    
    static func update() {
        update(data: transactions)
        for observer in observers {
            observer.update()
        }
    }
    
    fileprivate static func update(data: [String : Transaction]) {
        LocalAccess.updateDictionary(data: transactions)
        
        TransactionControllerNeedsUpdate = true
        analysisViewController = true
    }
    
    static let dummyTransaction =
        Transaction(name: "test1", transactionType: TransactionType.income, vendor: "Apple", amount: 10.00, date: TransactionDate.getCurrentDate(), location: "N/A", image: false, notes: "notes", budgetDate: BudgetDate(Date()), items: [:])
}
