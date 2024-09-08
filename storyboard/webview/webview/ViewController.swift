//
//  ViewController.swift
//  webview
//
//  Created by sunjae on 9/7/24.
//

import UIKit
import WebKit // WKWebView

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String){ // 지정된 url을 통한 웹 페이지를 로드하는 함수
        let myUrl = URL(string: url) // String -> URL
        let myRequest = URLRequest(url: myUrl!) // Request
        webView.load(myRequest)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        loadWebPage("https://blog.naver.com/sunjaenation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) { // 로딩
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { // 로딩 완료
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) { //에러
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func checkUrl(_ url: String) -> String { // 자동 삽입 기능 (필요한 경우만..)
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if(!flag){
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btnGoToUrl(_ sender: UIButton) {
      //  checkUrl(urlTextField.text!)
        loadWebPage(urlTextField.text ?? "")
        urlTextField.text = ""
    }

    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("https://www.naver.com")
    }
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("https://www.youtube.com")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html") // 파일 경로
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func btnRewind(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func btnFastForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    
    
    
    
    
}

