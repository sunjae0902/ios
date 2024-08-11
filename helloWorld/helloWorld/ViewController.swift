//
//  ViewController.swift
//  helloWorld
//
//  Created by sunjae on 8/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        for family in UIFont.familyNames.sorted() {
        //            let names = UIFont.fontNames(forFamilyName: family)
        //            print("Family: \(family) Font names: \(names)")
        //        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var nickname: UITextField!
    
    @IBOutlet var introduce: UITextField!
    
    
    @IBAction func btnSend(_ sender: UIButton) {
        bottomText.text = "Hello, I'm \(nickname.text!) \(introduce.text!)"
    }
    
    @IBOutlet var bottomText: UILabel!
}



