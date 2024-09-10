//
//  ViewController.swift
//  tab
//
//  Created by sunjae on 9/10/24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnGoToImgView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func btnGoToDatePickerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
}

