//
//  BudgetItemTableViewDelegate.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol BudgetItemTableViewDelegate {
    func performSegue(withIdentifier: String, sender: Any?)
}
