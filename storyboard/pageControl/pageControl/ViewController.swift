//
//  ViewController.swift
//  pageControl
//
//  Created by sunjae on 9/9/24.
//

import UIKit

let PAGE_NUM = 10

class ViewController: UIViewController {
    @IBOutlet var lblNumber: UILabel!
    @IBOutlet var pageControlView: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControlView.currentPage = 0
        pageControlView.numberOfPages = PAGE_NUM
        pageControlView.currentPageIndicatorTintColor = UIColor.green
        pageControlView.pageIndicatorTintColor = UIColor.gray
        lblNumber.text = String(pageControlView.currentPage+1)
    }
    @IBAction func pageController(_ sender: UIPageControl) {
        lblNumber.text = String(pageControlView.currentPage+1)
    }
}

