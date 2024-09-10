//
//  ViewController.swift
//  datePicker
//
//  Created by sunjae on 9/3/24.
//

import UIKit

class DatePickerViewController: UIViewController {
    let timeSelector: Selector = #selector(DatePickerViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime = ""
    
    @IBOutlet var curDateTime: UILabel!
    @IBOutlet var selectedDateTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true) // 타이머 간격, 동작할 뷰, 실행할 함수, 유저 정보, 반복 여부
        
    
    }

    @IBAction func selectDateTime(_ sender: UIDatePicker) {
        let datePickerView = sender;
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE" // formatter 속성 지정
        selectedDateTime.text = "선택 시간: " + formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date) // Date -> String
    }
    
    @objc func updateTime(){ // #selector()의 인자로 사용될 경우 -> objc 어노테이션 사용(obj-c코드 사용)
//        curDateTime.text = String(count)
//        count += 1
        
        let date = NSDate() // 현재 시간 가져옴
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        curDateTime.text = "현재 시간: " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTime = formatter.string(for: date) // Any? -> String 변환
        
        if(currentTime == alarmTime){
            view.backgroundColor = UIColor.red
        }
        else{
            view.backgroundColor = UIColor.white
        }
    }

    
}

