//
//  ViewController.swift
//  alertPractice
//
//  Created by sunjae on 9/6/24.
//

import UIKit

class ViewController: UIViewController{
    let timeSelector: Selector = #selector(ViewController.updateTime) // updateTime 실행
    let interval = 1.0
    var alarmTime: String?
    var alertFlag = false

    @IBOutlet var lblCurTime: UILabel!
    @IBOutlet var lblSelectedTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true) // 타이머 간격, 동작할 뷰, 실행할 함수, 유저 정보, 반복 여부
    }
    
    @IBAction func changeDateTime(_ sender: UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblSelectedTime.text = "선택 시간: " + dateFormatter.string(from: date)
        dateFormatter.dateFormat = "hh:mm aaa"
        alarmTime = dateFormatter.string(from: date) // 변경된 시간 저장
    }
    
    @objc func updateTime(){ //
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurTime.text = "현재 시간: " + dateFormatter.string(from: date as Date)
        
        dateFormatter.dateFormat = "hh:mm aaa"
        let curTime = dateFormatter.string(from: date as Date)
        
        if (alarmTime == curTime) {
            if (!alertFlag) {
                let alert = UIAlertController(title:"알림", message: "설정된 시간입니다!", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "네, 알겠습니다", style: UIAlertAction.Style.default)
                alertFlag = true
                alert.addAction(action)
                present(alert, animated: true)
            }
        } else{
            alertFlag = false
        }
        
    }
    
    
}

