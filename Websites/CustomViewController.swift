//
//  CustomViewController.swift
//  Websites
//
//  Created by Macbook on 19.02.18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    var viewController : UISplitViewController!
    var urladd : String?
    var check : Bool?
    
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    var previousViewController : MasterViewController?
    @IBOutlet weak var second_background: UIView!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myIndicator.hidesWhenStopped = true
        // myIndicator.startAnimating()
    }
    func configureView(urladdr : String?) {
        myIndicator.startAnimating()
        myIndicator.hidesWhenStopped = true
        if check == true{
            self.view.backgroundColor = .red }
        else{
            self.view.backgroundColor = .black
        }
        if (webView) != nil {
            let url = URL(string: urladdr!)
            webView.loadRequest(URLRequest(url: url!))
            if !webView.isLoading{
                myIndicator.stopAnimating()
            }
        }
        
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myIndicator.stopAnimating()}
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        myIndicator.stopAnimating()
    }
    
    
}

