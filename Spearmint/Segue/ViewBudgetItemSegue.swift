//
//  ViewBudgetItemSegue.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class ViewBudgetItemSegue: UIStoryboardSegue, SegueIdentifier {
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        if let _ = identifier {
            super.init(identifier: identifier, source: source, destination: destination)
        } else {
            super.init(identifier: ViewBudgetItemSegue.SegueIdentifier, source: source, destination: destination)
        }
        setUp()
    }
    
    func setUp() {
    }
}
