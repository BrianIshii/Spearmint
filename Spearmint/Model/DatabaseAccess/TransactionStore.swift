//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TransactionStore {
    public static var transactions: [String: Transaction] = getAllTransactions()
    
    private static let transactionString = "transactions"
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let transactionURL = documentsDirectory.appendingPathComponent(transactionString)
    
    static func addTransaction(_ transaction: Transaction) {
        transactions[transaction.id.description()] = transaction
        update()
    }
    
    static func deleteTransaction(_ transaction: Transaction) {
        transactions.removeValue(forKey: transaction.id.description())
        update()
    }
    
    private static func getAllTransactions() -> [String: Transaction] {
        var transactions: [String: Transaction]
        
        if LocalAccess.reset {
            update(data: [String: Transaction](), url: transactionURL)
            return [String: Transaction]()
        }
        
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
    
    static func update() {
        update(data: transactions, url: transactionURL)
    }
    
    fileprivate static func update(data: [String : Transaction], url: URL) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
    }
}
