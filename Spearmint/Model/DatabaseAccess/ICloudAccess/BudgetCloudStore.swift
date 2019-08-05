//
//  BudgetCloudStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class BudgetCloudStore: CloudStore {
    func createRecord(_ item: Budget) -> CKRecord {
        let recordID = CKRecord.ID(recordName: item.budgetDate.month + item.budgetDate.year)
        let budgetRecord = CKRecord(recordType: "Budget", recordID: recordID)
        let budgetItemsRecord = CKRecord(recordType: "Budget.items", recordID: recordID)
        
        var transactionStrings: [NSString] = []
        for transactionID in item.transactions {
            transactionStrings.append(transactionID.id as NSString)
        }
        
        budgetRecord["transactionIDs"] = transactionStrings as NSArray
        
        for (k,v) in item.items {
            var ids: [NSString] = []
            for id in v {
                ids.append(id.id as NSString)
            }
            budgetItemsRecord[k.rawValue] = ids as NSArray
        }
        
        budgetRecord["items"] = budgetItemsRecord.share
        
        return budgetRecord
    }
    
    typealias Item = Budget

    func createItem(from record: CKRecord) -> Budget {
        
        var transactions: [TransactionID] = []
        if let temp = record.value(forKeyPath: "transactionIDs") as? NSArray {
        }
            
        return Budget(date: BudgetDate(), transactions: transactions, items: [:])
    }
    
    func createRecords(_ item: Budget) -> [CKRecord] {
        let recordID = CKRecord.ID(recordName: item.budgetDate.month + item.budgetDate.year)
        let budgetRecord = CKRecord(recordType: "Budget", recordID: recordID)
        let budgetItemsRecord = CKRecord(recordType: "Budgetitems", recordID: recordID)
        
        var transactionStrings: [NSString] = []
        for transactionID in item.transactions {
            transactionStrings.append(transactionID.id as NSString)
        }
        if transactionStrings.count > 0 {
            budgetRecord["transactionIDs"] = transactionStrings as NSArray
        }
        
        for (k,v) in item.items {
            var ids: [NSString] = []
            for id in v {
                ids.append(id.id as NSString)
            }
            if ids.count > 0 {
                budgetItemsRecord[k.rawValue.replacingOccurrences(of: " ", with: "")] = ids as NSArray
            }
        }
        
        budgetRecord["items"] = budgetItemsRecord.share
        
        return [budgetItemsRecord, budgetRecord]
    }
    
    
    
}
