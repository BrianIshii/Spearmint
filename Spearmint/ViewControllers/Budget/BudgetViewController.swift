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
    @IBOutlet weak var budgetButton: UIButton!
    
    var budgets: [Budget] = []
    var currentBudget: Budget?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        budgets = [Budget(date: "2019-01", items: []),
                   Budget(date: "2019-02", items: []),
                   Budget(date: "2019-03", items: []),
                   Budget(date: "2019-04", items: []),
                   Budget(date: "2019-05", items: [])]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(DateFormatterFactory.yearAndMonthFormatter.string(from: Date()))
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: BudgetCollectionViewCell.xib, bundle: nil), forCellWithReuseIdentifier: BudgetCollectionViewCell.xib)

        currentBudget = budgets[budgets.count - 1]
        budgetButton.setTitle(DateFormatterFactory.monthFullFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: currentBudget!.date)!), for: .normal)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BudgetCollectionViewCell.xib, for: indexPath) as! BudgetCollectionViewCell

        let currentBudget = budgets[indexPath.row]
        let date = DateFormatterFactory.yearAndMonthFormatter.date(from: currentBudget.date)
        let month = DateFormatterFactory.monthThreeCharacterFormatter.string(from: date!)
        let year = DateFormatterFactory.yearTwoCharacterFormatter.string(from: date!)
        
        cell.monthLabel.text = month
        cell.yearLabel.text = year
        
        print(month)
        print(year)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentBudget = budgets[indexPath.row]
        
        collectionView.isHidden = true
        budgetButton.setTitle(DateFormatterFactory.monthFullFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: currentBudget!.date)!), for: .normal)
    }
    
    @IBAction func toggleSelectBudget(_ sender: UIButton) {
        collectionView.isHidden = !collectionView.isHidden
    }
    
}
