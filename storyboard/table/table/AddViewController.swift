//
//  AddViewController.swift
//  table
//
//  Created by sunjae on 9/15/24.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var iconName = ""
    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var iconImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        iconName = itemsImageFile[0]
        iconImgView.image = UIImage(systemName: iconName)
        pickerView.delegate = self
        
    }

    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append(iconName)
        tfAddItem.text = ""
        _ = navigationController?.popViewController(animated: true) // pop
    }
    // 높이 설정
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    // 아이템 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemsImageFile.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = UIImage(systemName: itemsImageFile[row])
       return UIImageView(image: image)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        iconName = itemsImageFile[row]
        iconImgView.image = UIImage(systemName: itemsImageFile[row])
    }
    
   

    
    
    
}
