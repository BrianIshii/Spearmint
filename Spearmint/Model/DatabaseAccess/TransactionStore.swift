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
        
        return LocalAccess.getDictionary(saveable: Transaction.self)
    }
    
    static func update() {
        update(data: transactions)
    }
    
    fileprivate static func update(data: [String : Transaction]) {
        LocalAccess.updateDictionary(data: transactions)
        
        TransactionControllerNeedsUpdate = true
        analysisViewController = true
    }
}
