//
//  ViewController.swift
//  helloWorld
//
//  Created by sunjae on 8/11/24.
//

import UIKit

class ImageViewController: UIViewController {
    var imgNum = 1
    let maxImage = 4
    
    @IBOutlet var imageView: UIImageView! // outlet 변수 선언
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "1.png")
    }
    
    
    @IBAction func previousAction(_ sender: UIButton) {
        if(imgNum == 1){
            imgNum = maxImage
        }
        else{
            imgNum -= 1
        }
        imageView.image = UIImage(named: String(imgNum) + ".png")
    }
    
    
    @IBAction func nextAction(_ sender: UIButton) {
        if(imgNum == maxImage){
            imgNum = 1
        }
        else{
            imgNum += 1
        }
        imageView.image = UIImage(named: String(imgNum) + ".png")
    }
    
}



