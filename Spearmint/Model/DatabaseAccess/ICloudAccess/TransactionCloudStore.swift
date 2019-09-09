//
//  TransactionCloudStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class TransactionCloudStore: CloudStore {
    
    typealias Item = Transaction

    func createItem(from record: CKRecord) -> Transaction {
        let id: String = record.recordID.recordName
        
        var name = ""
        if let temp = record.value(forKeyPath: "name") as? String {
            name = temp
        }
        
        var transactionType = TransactionType.expense
        if let temp = record.value(forKeyPath: "transactionType") as? Int {
            switch temp {
            case 0:
                transactionType = TransactionType.expense
            default:
                transactionType = TransactionType.income
            }
        }
        
        var vendorID: VendorID
        if let temp = record.value(forKeyPath: "vendorID") as? String {
            vendorID = VendorID(temp)
        } else {
            vendorID = VendorID()
        }
        
        var amount: Float
        if let temp = record.value(forKeyPath: "amount") as? Float {
            amount = temp
        } else {
            amount = 0.0
        }
        
        var transactionDate: TransactionDate
        var budgetDate: BudgetDate
        if let temp = record.value(forKeyPath: "date") as? Date {
            transactionDate = TransactionDate(temp)
            budgetDate = BudgetDate(temp)
        } else {
            transactionDate = TransactionDate(Date())
            budgetDate = BudgetDate(Date())
        }
        
        
        let budgetItemIDsStrings = record.value(forKey: "budgetItemIDs") as? [NSString] ?? []
        var budgetItems: [BudgetItemID: [Spearmint.Item]] = [:]
        for budgetItemIDsString in budgetItemIDsStrings {
            budgetItems[BudgetItemID(budgetItemIDsString as String)] = []
        }
        
        
        let tagStrings = record.value(forKey: "tags") as? [NSString] ?? []
        
        var tags: [String] = []
        
        for tagString in tagStrings {
            tags.append(tagString as String)
        }
        
        return Transaction(id: TransactionID(id), name: name, transactionType: transactionType, vendor: vendorID, amount: amount, date: transactionDate, location: "", image: false, tags: tags, notes: "", budgetDate: budgetDate, items: budgetItems)
    }
    
    func createRecord(_ item: Transaction) -> CKRecord {
        let transactionRecordID = CKRecord.ID(recordName: item.ID)
        let transactionRecord = CKRecord(recordType: "Transaction", recordID: transactionRecordID)
        
        transactionRecord["name"] = item.name as NSString
        transactionRecord["transactionType"] = item.transactionType.rawValue as NSNumber
        transactionRecord["paymentType"] = item.paymentType as NSString
        transactionRecord["vendorID"] = item.vendor.id as NSString
        transactionRecord["amount"] = item.amount as NSNumber
        transactionRecord["date"] = item.date.date as NSDate
        if item.tags.count > 0 {
            transactionRecord["tags"] = item.tags as NSArray
        }
        transactionRecord["notes"] = item.notes as NSString
        transactionRecord["amount"] = item.amount as NSNumber
        var budgetItemIDs: [NSString] = []
        var items: [NSString] = []
        for (k, v) in item.items {
            budgetItemIDs.append(k.id as NSString)
            for item in v {
                items.append(item.budgetItemName as NSString)
            }
        }
        
        if budgetItemIDs.count > 0 {
            transactionRecord["budgetItemIDs"] = budgetItemIDs as NSArray
        }
        if items.count > 0 {
            transactionRecord["items"] = items as NSArray
        }
        
        return transactionRecord
    }
}
