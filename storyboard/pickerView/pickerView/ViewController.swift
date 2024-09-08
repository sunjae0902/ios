//
//  ViewController.swift
//  pickerView
//
//  Created by sunjae on 9/4/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX = 4
    let COl = 2
    let PICKER_VIEW_HEIGHT: CGFloat = 80
    var imageArr = [UIImage?]() // optional로 지정
    var imageFileName = ["1.png", "2.png", "3.png","4.png"]
    // var name: [String] = ["lim", "kim", "park]
    // var emptyArr = [String]()
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var selectedItem: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX {
            let image = UIImage(named: imageFileName[i])
            imageArr.append(image)
        }
        
        selectedItem.text = "Selected item: " + imageFileName[0]
        imageView.image = imageArr[0]
    }
    
    // delegate method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return COl
    } // 컴포넌트의 수를 정수 값으로 넘겨줌
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count // 인수로 열의 개수를 전달, 해당 열에서 선택 가능한 행의 수(데이터 개수) 반환
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row]
//    }
// 각 열의 title을 string 값으로 넘겨줌, 이미지 파일명 반환
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            selectedItem.text = "Selected item: " + imageFileName[row]
        }
        if(component == 1){
            imageView.image = imageArr[row]
        }
    } // 선택한 항목 출력
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArr[row])
        imageView.frame = CGRect(x:0, y:0, width:100, height: 150)
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }


}

