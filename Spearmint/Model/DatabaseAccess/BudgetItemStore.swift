//
//  BudgetItemStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItemStore {
    fileprivate var budgetItemDictionary: [String: BudgetItem] = [:]
    fileprivate var activeBudgetItems: [BudgetItemCategory : [BudgetItemID]] = [:]
    
    init() {
        let dictionary = getBudgetItemDictionary()
        
        if dictionary.count == 0 {

            var dictionary: [String: BudgetItem] = [:]
            for budgetItem in defaultBudgetItems() {
                dictionary[budgetItem.id.id] = budgetItem
            }
            budgetItemDictionary = dictionary
        } else {
            budgetItemDictionary = dictionary
        }
        activeBudgetItems = getActiveBudgetItems()
    }

    public func getBudgetItems() -> [BudgetItemCategory : [BudgetItemID]] {
        return activeBudgetItems
    }
    
    public func getBudgetItem(_ budgetItemID: BudgetItemID) -> BudgetItem? {
        return budgetItemDictionary[budgetItemID.id] ?? nil
    }
    
    public func setActive(_ budgetItem: BudgetItem) {
        if let item = budgetItemDictionary[budgetItem.id.id] {
            item.isActive = true
        } else {
            budgetItemDictionary[budgetItem.id.id] = budgetItem
        }
    }
    
    public func setInactive(_ budgetItemID: BudgetItemID) {
        guard let item = budgetItemDictionary[budgetItemID.id] else { return }
        item.isActive = false
    }
    
    fileprivate func getBudgetItemDictionary() -> [String: BudgetItem] {
        return LocalAccess.getDictionary(key: String.self, object: BudgetItem.self)
    }
    
    fileprivate func getActiveBudgetItems() -> [BudgetItemCategory : [BudgetItemID]] {
        var active = createEmptyBudgetItemDictionary()
        
        for (_, budgetItem) in budgetItemDictionary {
            if budgetItem.isActive {
                if active[budgetItem.category] != nil {
                    active[budgetItem.category]!.append(budgetItem.id)
                }
            }
        }
        return active
    }
    
    fileprivate func updateBudgetItemDictionary() {
        LocalAccess.updateDictionary(data: budgetItemDictionary)
    }
    
    fileprivate func defaultBudgetItemDictionary() -> [BudgetItemCategory:[BudgetItem]] {
        return [BudgetItemCategory.income : [
            BudgetItem(name: "Paycheck 1", category: BudgetItemCategory.income, planned: 6000)],
                BudgetItemCategory.housing : [
                    BudgetItem(name: "Mortgage/Rent", category: BudgetItemCategory.housing, planned: 2500),
                    BudgetItem(name: "Water", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Natural Gas", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Electricity", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Cable", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Internet", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Trash", category: BudgetItemCategory.housing)],
                BudgetItemCategory.transportation : [
                    BudgetItem(name: "Gas", category: BudgetItemCategory.transportation, planned: 200),
                    BudgetItem(name: "Maintenance", category: BudgetItemCategory.transportation)],
                BudgetItemCategory.giving : [
                    BudgetItem(name: "Charity", category: BudgetItemCategory.giving)],
                BudgetItemCategory.savings : [
                    BudgetItem(name: "Retirement", category: BudgetItemCategory.savings, planned: 2000)],
                BudgetItemCategory.food : [
                    BudgetItem(name: "Groceries", category: BudgetItemCategory.food),
                    BudgetItem(name: "Eating Out", category: BudgetItemCategory.food)],
                BudgetItemCategory.personal : [
                    BudgetItem(name: "Personal Items", category: BudgetItemCategory.personal, planned: 250),
                    BudgetItem(name: "Subscriptions", category: BudgetItemCategory.personal)],
                BudgetItemCategory.lifestyle : [
                    BudgetItem(name: "Movies", category: BudgetItemCategory.lifestyle),
                    BudgetItem(name: "Outdoor Stuff", category: BudgetItemCategory.lifestyle)],
                BudgetItemCategory.health : [
                    BudgetItem(name: "Rock Climbing Gym", category: BudgetItemCategory.health)],
                BudgetItemCategory.insurance : [
                    BudgetItem(name: "Health Insurance", category: BudgetItemCategory.insurance),
                    BudgetItem(name: "Car Insurance", category: BudgetItemCategory.insurance)],
                BudgetItemCategory.debt : [
                    BudgetItem(name: "Credit Card", category: BudgetItemCategory.debt),
                    BudgetItem(name: "Student Loan", category: BudgetItemCategory.debt)],
                BudgetItemCategory.other : []]
    }
    
    fileprivate func defaultBudgetItems() -> [BudgetItem] {
        return [
            // income
            BudgetItem(name: "Paycheck 1", category: BudgetItemCategory.income, planned: 6000),
            // housing
            BudgetItem(name: "Mortgage/Rent", category: BudgetItemCategory.housing, planned: 2500),
            BudgetItem(name: "Water", category: BudgetItemCategory.housing),
            BudgetItem(name: "Natural Gas", category: BudgetItemCategory.housing),
            BudgetItem(name: "Electricity", category: BudgetItemCategory.housing),
            BudgetItem(name: "Cable", category: BudgetItemCategory.housing),
            BudgetItem(name: "Internet", category: BudgetItemCategory.housing),
            BudgetItem(name: "Trash", category: BudgetItemCategory.housing),
            // transportation
            BudgetItem(name: "Gas", category: BudgetItemCategory.transportation, planned: 200),
            BudgetItem(name: "Maintenance", category: BudgetItemCategory.transportation),
            // giving
            BudgetItem(name: "Donations", category: BudgetItemCategory.giving),
            BudgetItem(name: "Gifts", category: BudgetItemCategory.giving),
            // savings
            BudgetItem(name: "Retirement", category: BudgetItemCategory.savings, planned: 2000),
            // food
            BudgetItem(name: "Groceries", category: BudgetItemCategory.food),
            BudgetItem(name: "Eating Out", category: BudgetItemCategory.food),
            // personal
            BudgetItem(name: "Personal Items", category: BudgetItemCategory.personal, planned: 250),
            BudgetItem(name: "Subscriptions", category: BudgetItemCategory.personal),
            // lifestyle
            BudgetItem(name: "Movies", category: BudgetItemCategory.lifestyle),
            BudgetItem(name: "Outdoor Stuff", category: BudgetItemCategory.lifestyle),
            // health
            BudgetItem(name: "Rock Climbing Gym", category: BudgetItemCategory.health),
            // insurance
            BudgetItem(name: "Health Insurance", category: BudgetItemCategory.insurance),
            BudgetItem(name: "Car Insurance", category: BudgetItemCategory.insurance),
            // debt
            BudgetItem(name: "Credit Card", category: BudgetItemCategory.debt),
            BudgetItem(name: "Student Loan", category: BudgetItemCategory.debt)
        ]
    }
    
    fileprivate func createEmptyBudgetItemDictionary() -> [BudgetItemCategory:[BudgetItemID]] {
        return [BudgetItemCategory.income : [],
                BudgetItemCategory.housing : [],
                BudgetItemCategory.transportation : [],
                BudgetItemCategory.giving : [],
                BudgetItemCategory.savings : [],
                BudgetItemCategory.food : [],
                BudgetItemCategory.personal : [],
                BudgetItemCategory.lifestyle : [],
                BudgetItemCategory.health : [],
                BudgetItemCategory.insurance : [],
                BudgetItemCategory.debt : [],
                BudgetItemCategory.other : []]
    }
}
