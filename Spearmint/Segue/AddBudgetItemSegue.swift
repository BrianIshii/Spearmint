//
//  AddBudgetItemSegue.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddBudgetItemSegue: UIStoryboardSegue {
    static let segueIdentifier = "addBudgetItemSegue"
    
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        setUp()
    }
    
    func setUp() {
    }
}
