//
//  AddTransactionDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/30/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddTransactionDataSource: DataSource {
    var fields: [String] = []
    
    override init(tableView: UITableView) {
        super.init(tableView: tableView)
        
        tableView.register(UINib.init(nibName: AddTransactionFieldTableViewCell.xib, bundle: nil), forCellReuseIdentifier: AddTransactionFieldTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }
}

extension AddTransactionDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddTransactionFieldTableViewCell.reuseIdentifier, for: indexPath) as! AddTransactionFieldTableViewCell

        configure(cell: cell, indexPath: indexPath)
        
        return UITableViewCell()
    }
    
    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        let field = fields[indexPath.row]
        
        if let cell = cell as? AddTransactionFieldTableViewCell {
            cell.configure(object: field)
        }
    }
    
}
