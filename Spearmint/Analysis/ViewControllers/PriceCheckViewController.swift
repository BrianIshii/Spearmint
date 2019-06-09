//
//  PriceCheckViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/25/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class PriceCheckViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var item: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        if let i = item {
            navBar.topItem?.title = i
            webView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.google.com/search?q=\(i)&tbm=shop")! as URL) as URLRequest)
            
        }
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
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
