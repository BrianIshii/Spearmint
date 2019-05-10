//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class LocalAccess {
    public static var transactions: [String: Transaction] = getAllTransactions()
    
    private static let transactionString = "transactions"
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let transactionURL = documentsDirectory.appendingPathComponent(transactionString)
    
    static func addTransaction(transaction: Transaction) {
        transactions[transaction.id.description()] = transaction
        updateTransactionPersistentStorage()
    }
    
    static func deleteTransaction(transaction: Transaction) {
        transactions.removeValue(forKey: transaction.id.description())
        updateTransactionPersistentStorage()
    }
    
    private static func getAllTransactions() -> [String: Transaction] {
        var transactions: [String: Transaction]
        
        do {
            let data = try Data(contentsOf: transactionURL)
            let decoder = JSONDecoder()
            let tempArr = try decoder.decode([String: Transaction].self, from: data)
            transactions = tempArr
            
            return transactions

        } catch {
            print(error)
        }
        
        return [String: Transaction]()
    }
    
    static func updateTransactionPersistentStorage() {
        // persist data
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(transactions)
            try jsonData.write(to: transactionURL)
        } catch {
            print(error)
        }
    }
}
