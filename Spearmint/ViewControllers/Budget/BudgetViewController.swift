//
//  BudgetViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: BudgetItemListTableView!
    @IBOutlet weak var budgetButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var budgets: [Budget] = []
    var sections: [BudgetItemSection] = [
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

    var canRearrangeSections = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.isHidden = true
        
        budgets = BudgetStore.budgets
//        budgets = [Budget(date: "2019-01", items: [:]),
//                   Budget(date: "2019-02", items: [:]),
//                   Budget(date: "2019-03", items: [:]),
//                   Budget(date: "2019-04", items: [:]),
//                   Budget(date: "2019-05", items: BudgetItem.defaultBudgetItems())]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(DateFormatterFactory.yearAndMonthFormatter.string(from: Date()))
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: BudgetCollectionViewCell.xib, bundle: nil), forCellWithReuseIdentifier: BudgetCollectionViewCell.reuseIdentifier)

        tableView.currentBudget = budgets[budgets.count - 1]
        tableView.reloadData()
        
        budgetButton.setTitle(tableView.currentBudget?.month, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        
        tableView.currentBudget = budgets[indexPath.row]
        
        collectionView.isHidden = true
        budgetButton.setTitle(tableView.currentBudget?.month, for: .normal)

        tableView.reloadData()
    }
    
    @IBAction func toggleSelectBudget(_ sender: UIButton) {
        collectionView.isHidden = !collectionView.isHidden
    }
    
    @IBAction func rearrangeButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Rearrange" {
            for i in 0..<sections.count {
                tableView.sections[i].collapse()
            }
            sender.title = "Done"
            budgetButton.isEnabled = false
            tableView.canRearrangeSections = true
        } else {
            for i in 0..<sections.count {
                tableView.sections[i].expand()
            }
            sender.title = "Rearrange"
            budgetButton.isEnabled = true
            tableView.canRearrangeSections = false
        }
        tableView.reloadData()
        
    }
    
    
}
