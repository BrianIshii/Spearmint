//
//  AddTransactionViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed(DateTableViewCell.xib, owner: self, options: nil)?.first as! DateTableViewCell
            
            return cell
        } else if indexPath.row == 1 {
            let cell = Bundle.main.loadNibNamed(AmountTableViewCell.xib, owner: self, options: nil)?.first as! AmountTableViewCell
            
            return cell
        } //else if indexPath.row == 2 {
        else {
            let cell = Bundle.main.loadNibNamed(VendorTableViewCell.xib, owner: self, options: nil)?.first as! VendorTableViewCell
            
            return cell
        }
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
