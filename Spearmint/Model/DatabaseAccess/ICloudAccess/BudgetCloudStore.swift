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
    typealias Item = Budget

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
    
    func createItem(from record: CKRecord) -> Budget {
        let date = record.recordID.recordName
        let transactionIDStrings = record.value(forKey: "transactionIDs") as? [NSString] ?? []
        var transactionIDs: [TransactionID] = []
        
        for transactionID in transactionIDStrings {
            transactionIDs.append(TransactionID(transactionID as String))
        }
            
        return Budget(date: BudgetDate(date), transactions: transactionIDs, items: [:])
    }
    
    func createRecords(_ item: Budget) -> [CKRecord] {
        let recordID = CKRecord.ID(recordName: item.budgetDate.dateString)
        let budgetRecord = CKRecord(recordType: "Budget", recordID: recordID)
        let budgetItemID = CKRecord.ID(recordName: "\(item.budgetDate.dateString)items")
        let budgetItemsRecord = CKRecord(recordType: "Budgetitems", recordID: budgetItemID)
        
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
                budgetItemsRecord[k.rawValue.replacingOccurrences(of: " ", with: "0")] = ids as NSArray
            }
        }
        
        budgetRecord["items"] = CKRecord.Reference(record: budgetItemsRecord, action: CKRecord_Reference_Action.deleteSelf)
        
        return [budgetItemsRecord, budgetRecord]
    }
    
    
    
}
