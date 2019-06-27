//
//  BudgetViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var budgetButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    fileprivate var budgetTableViewContoller: BudgetTableViewController?
    
    var budgets: [Budget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.isHidden = true
        
        budgets = BudgetStore.budgets
        
        if Date().isInSameMonth(date: budgets[budgets.count - 1].date) {
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
            BudgetStore.addBudget(Budget(date: Budget.dateToString(nextMonth!), items: LocalAccess.budgetItemStore.getBudgetItems()))
        }
        
        budgets = BudgetStore.budgets
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(DateFormatterFactory.yearAndMonthFormatter.string(from: Date()))
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: BudgetCollectionViewCell.xib, bundle: nil), forCellWithReuseIdentifier: BudgetCollectionViewCell.reuseIdentifier)
        
        collectionView.accessibilityScroll(UIAccessibilityScrollDirection.right)
        
        budgetButton.setTitle(BudgetStore.getBudget(BudgetDate(Date()))?.month, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let viewController = budgetTableViewContoller, BudgetStore.budgetViewControllerNeedsUpdate {
            budgets = BudgetStore.budgets
            collectionView.reloadData()
            viewController.tableView.reloadData()
            BudgetStore.budgetViewControllerNeedsUpdate = false
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination
        
        if let vc = destination as? BudgetTableViewController {
            budgetTableViewContoller = vc
        }
    }
    
    @IBAction func toggleSelectBudget(_ sender: UIButton) {
        collectionView.isHidden = !collectionView.isHidden
    }
    
    @IBAction func rearrangeButtonPressed(_ sender: UIBarButtonItem) {
        if let budgetTableView = budgetTableViewContoller {
            if sender.title == "Rearrange" {
                sender.title = "Done"
                budgetButton.isEnabled = false
            } else {
                sender.title = "Rearrange"
                budgetTableView.updateBudgetItemSections()
                budgetButton.isEnabled = true
            }
            
            budgetTableView.toggleRearrangingSections()
        }
    }
    
    @IBAction func unwindToBudgetItems(sender: UIStoryboardSegue) {
        if let source = sender.source as? AddBudgetItemViewController, let budgetItem = source.budgetItem {
            budgetTableViewContoller!.addBudgetItem(budgetItem)
        }
    }
}

extension BudgetViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return budgets.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BudgetCollectionViewCell.reuseIdentifier, for: indexPath) as! BudgetCollectionViewCell
        
        let currentBudget = budgets[indexPath.row]
        
        cell.monthLabel.text = currentBudget.month.prefix(3).description
        cell.yearLabel.text = currentBudget.year.dropFirst(2).description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let budgetTableView = budgetTableViewContoller {
            budgetTableView.updateBudget(budget: budgets[indexPath.row])
            
        }
        collectionView.isHidden = true
        budgetButton.setTitle(budgets[indexPath.row].month, for: .normal)
    }
}
