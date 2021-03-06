//
//  AddTransactionSegue.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddTransactionSegueOld: UIStoryboardSegue, SegueIdentifier {

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        if identifier != nil {
            super.init(identifier: identifier, source: source, destination: destination)
        } else {
            super.init(identifier: AddTransactionSegue.SegueIdentifier, source: source, destination: destination)
        }
    }
}
