//
//  DetailViewController.swift
//  table
//
//  Created by sunjae on 9/15/24.
//

import UIKit

class DetailViewController: UIViewController {
    var itemTitle = ""

    @IBOutlet var lblItem: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblItem.text = itemTitle // 뷰가 나올때마다 표시.
        // Do any additional setup after loading the view.
    }
    func receiveItem(_ title: String){
        itemTitle = title
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
