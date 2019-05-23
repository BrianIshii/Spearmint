//
//  BudgetItemSectionStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItemSectionStore {
    public static var budgetItemSections: [BudgetItemSection] = getBudgetItemSections()
    
    private static let budgetItemSectionString = "budgetItemSectionString"
    private static let budgetItemSectionURL = LocalAccess.documentsDirectory.appendingPathComponent(budgetItemSectionString)
    public static let defaultSections: [BudgetItemSection] = [
        BudgetItemSection(category: .income),
        BudgetItemSection(category: .housing),
        BudgetItemSection(category: .transportation),
        BudgetItemSection(category: .giving),
        BudgetItemSection(category: .savings),
        BudgetItemSection(category: .food),
        BudgetItemSection(category: .personal),
        BudgetItemSection(category: .lifestyle),
        BudgetItemSection(category: .health),
        BudgetItemSection(category: .insurance),
        BudgetItemSection(category: .debt),
        BudgetItemSection(category: .other)]
    
    private static func getBudgetItemSections() -> [BudgetItemSection] {
        var budgetItemSections: [BudgetItemSection] = []
        
        if LocalAccess.reset {
            return resetBudgetItemSections()
        }
        do {
            let data = try Data(contentsOf: budgetItemSectionURL)
            let decoder = JSONDecoder()
            let temp = try decoder.decode([BudgetItemSection].self, from: data)
            
            budgetItemSections = temp
            return budgetItemSections
        } catch {
            print(error)
        }
        
        return resetBudgetItemSections()
    }
    
    fileprivate static func resetBudgetItemSections() -> [BudgetItemSection] {
        var budgetItemSections: [BudgetItemSection] = []

        budgetItemSections = defaultSections
        update(budgetItemSections)
        return budgetItemSections
    }
    
    public static func update() {
        update(budgetItemSections)
    }
    
    fileprivate static func update(_ data: [BudgetItemSection]) {
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: budgetItemSectionURL)
        } catch {
            print(error)
        }
    }
}
