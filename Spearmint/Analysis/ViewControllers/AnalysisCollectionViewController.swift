//
//  AnalysisCollectionViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/25/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

private let reuseIdentifier = "analysisCell"
private let segueIdentifer = "analysisSegue"

class AnalysisCollectionViewController: UICollectionViewController {
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let budget = LocalAccess.Budgets.get(BudgetDate(Date()))
        
        let mostExpensiveItems = budget!.mostExpensiveItemPerCategory
        
        for (_,v) in mostExpensiveItems {
            items.append(v)
        }
        reloadInputViews()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if LocalAccess.Transactions.analysisViewController {
//            LocalAccess.Transactions.analysisViewController = false
//        
//            let budget = BudgetStore.getBudget(BudgetDate(Date()))
//
//            let mostExpensiveItems = budget!.mostExpensiveItemPerCategory
//            
//            for (_,v) in mostExpensiveItems {
//                items.append(v)
//            }
//            
//            self.reloadInputViews()
//        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? PriceCheckViewController {
            vc.item = items[collectionView.indexPathsForSelectedItems![0].row].name
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnalysisCollectionViewCell
    
        let item = items[indexPath.row]

        // Configure the cell
        cell.category.text = "Most Expensive Item for: \(item.budgetItemCategory.rawValue)"
        cell.name.text = item.name
        cell.price.text = "Current Price: \(Currency.currencyFormatter(item.amount))"
        cell.backgroundColor = .lightGray
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
