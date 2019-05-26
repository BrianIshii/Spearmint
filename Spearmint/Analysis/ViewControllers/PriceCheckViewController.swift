//
//  PriceCheckViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/25/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class PriceCheckViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        webView.loadHTMLString("/search?q=ios&tbm=shop", baseURL: URL(fileURLWithPath: "https://www.google.com"))
        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.google.com/search?q=paper&tbm=shop")! as URL) as URLRequest)

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
