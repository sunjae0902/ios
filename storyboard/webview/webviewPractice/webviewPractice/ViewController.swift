//
//  ViewController.swift
//  webviewPractice
//
//  Created by sunjae on 9/7/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.navigationDelegate = self // viewcontroller에 위임
        let filePath = Bundle.main.path(forResource: "htmlView", ofType:"html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityView.startAnimating()
        activityView.isHidden = false
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
        activityView.isHidden = true
    }


}

