//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class LocalAccess {
    
    private static let transactions = "transactions"
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let transactionURL = documentsDirectory.appendingPathComponent(transactions)
    
    
    static func getAllTransactions() -> [Transaction] {
        var transactions: [Transaction]
        
        do {
            let data = try Data(contentsOf: transactionURL)
            let decoder = JSONDecoder()
            let tempArr = try decoder.decode([Transaction].self, from: data)
            transactions = tempArr
            
            return transactions

        } catch {
            print(error)
        }
        
        return [Transaction]()
    }
    
    static func updateTransactionPersistentStorage(transactions: [Transaction]) {
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
