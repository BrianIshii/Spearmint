//
//  PriceCheckViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/25/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit
import WebKit

class PriceCheckViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navBar: UINavigationBar!
    var item: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let i = item {
            navBar.topItem?.title = i
            let urli = i.trimmingCharacters(in: NSCharacterSet.whitespaces).replacingOccurrences(of: " ", with: "+")
            let urlString = "https://www.google.com/search?q=\(urli)&tbm=shop"
            webView.load(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)
            
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
