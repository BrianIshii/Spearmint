//
//  BudgetTableViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

//protocol BudgetTableViewProviderDelegate: class {
//    func didSelectBudget(_ budget: Budget)
//}

class BudgetTableViewController: UITableViewController {

    //weak var delegate: BudgetTableViewProviderDelegate?
    private var dataSource: BudgetDataSourceOld?
    private var selectedBudgetItem: BudgetItem?
    private let budgetItemSegue = "BudgetItemSegue"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64.0
        tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        dataSource = BudgetDataSourceOld(tableView: tableView)
        
        if let ds = dataSource {
            ds.currentBudget = BudgetStoreOld.getBudget(BudgetDate(Date()))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBudgetItem = dataSource?.getBudgetItem(indexPath: indexPath)
        performSegue(withIdentifier: budgetItemSegue, sender: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func toggleRearrangingSections() {
        guard let dataSource = dataSource else { return }

        dataSource.canRearrangeSections = !dataSource.canRearrangeSections
        tableView.reloadData()
    }
    
    func updateBudget(budget: Budget) {
        guard let dataSource = dataSource else { return }

        dataSource.currentBudget = budget
        tableView.reloadData()
    }
    
    func updateBudgetItemSections() {
        guard let dataSource = dataSource else { return }

        BudgetItemSectionStore.budgetItemSections = dataSource.sections
        BudgetItemSectionStore.update()
    }
    
    func addBudgetItem(_ budgetItem: BudgetItem) {
        guard let dataSource = dataSource else { return }
        guard let currentBudget = dataSource.currentBudget else { return }
        
        currentBudget.addBudgetItem(budgetItem: budgetItem)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let dataSource = dataSource else { return CGFloat(60) }
        
        if dataSource.canRearrangeSections {
            return CGFloat(30)
        }
        
        return CGFloat(60)
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? BudgetItemViewControllerOld {
            destination.budgetItem = selectedBudgetItem!
            destination.tableView = self
        }
    }
 

}
