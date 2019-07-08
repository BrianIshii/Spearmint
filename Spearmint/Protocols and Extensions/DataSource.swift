//
//  DataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/30/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

class DataSource: NSObject {
    fileprivate let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
}
