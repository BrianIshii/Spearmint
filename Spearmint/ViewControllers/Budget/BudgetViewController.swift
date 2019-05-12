//
//  BudgetViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetButton: UIButton!
    
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
    var currentBudget: Budget?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.isHidden = true
        
        budgets = [Budget(date: "2019-01", items: [:]),
                   Budget(date: "2019-02", items: [:]),
                   Budget(date: "2019-03", items: [:]),
                   Budget(date: "2019-04", items: [:]),
                   Budget(date: "2019-05", items: BudgetItem.defaultBudgetItems())]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(DateFormatterFactory.yearAndMonthFormatter.string(from: Date()))
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: BudgetCollectionViewCell.xib, bundle: nil), forCellWithReuseIdentifier: BudgetCollectionViewCell.reuseIdentifier)
        
        
        currentBudget = budgets[budgets.count - 1]
        budgetButton.setTitle(DateFormatterFactory.monthFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: currentBudget!.date)!), for: .normal)

        tableView.register(BudgetItemTableViewCell.self, forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
        tableView.register(UINib.init(nibName: BudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        currentBudget = budgets[indexPath.row]
        
        collectionView.isHidden = true
        budgetButton.setTitle(DateFormatterFactory.monthFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: currentBudget!.date)!), for: .normal)
        
        tableView.reloadData()
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sections[section].category.rawValue
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].isExpanded {
            return CGFloat(32)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add Item"
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sections[section].isExpanded {
            return CGFloat(32)
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (currentBudget?.items.keys.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].isExpanded {
            return (currentBudget?.items[sections[section].category]?.count)!
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sections[indexPath.section].isExpanded {
            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetItemTableViewCell.reuseIdentifier, for: indexPath) as! BudgetItemTableViewCell

            let currentBudgetItem = currentBudget!.items[sections[indexPath.section].category]![indexPath.row]
            
            cell.budgetItemName.text = currentBudgetItem.name
            cell.progressBar.progress = currentBudgetItem.actual / currentBudgetItem.planned
            
            return cell
        } else {
            
        }
    }
    
    // MARK: Textfield
    
    @IBAction func toggleSelectBudget(_ sender: UIButton) {
        collectionView.isHidden = !collectionView.isHidden
    }
    
    @IBAction func rearrangeButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Rearrange" {
            for i in 0..<sections.count {
                sections[i].collapse()
            }
            sender.title = "Done"
        } else {
            for i in 0..<sections.count {
                sections[i].expand()
            }
            sender.title = "Rearrange"
        }
        tableView.reloadData()
        
    }
    
    
}
