//
//  ViewController.swift
//  alert
//
//  Created by sunjae on 9/6/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var isOn = true;
    let imageOn = UIImage(systemName: "lightbulb.fill")
    let imageOff = UIImage(systemName: "lightbulb")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = imageOn
    }

    @IBAction func onAction(_ sender: UIButton) {
        switchLamp(isOnBtn: true)
    }
    @IBAction func offAction(_ sender: UIButton) {
       switchLamp(isOnBtn: false)
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        let removeAlert = UIAlertController(title: "램프 제거", message: "정말 전구를 제거하시겠어요?", preferredStyle: UIAlertController.Style.alert)
        let offAction = UIAlertAction(title: "아니요, 끌게요", style: UIAlertAction.Style.default, handler: {
            ACTION in self.imageView.image = self.imageOff
            self.isOn = false
        })
        let onAction = UIAlertAction(title: "아니요, 켤게요", style: UIAlertAction.Style.default, handler: {
            ACTION in self.imageView.image = self.imageOn // 익명 함수
            self.isOn = true
        })
        let removeAction = UIAlertAction(title: "네, 제거할게요", style: UIAlertAction.Style.default, handler: {
            ACTION in self.imageView.image = nil
            self.isOn = false
        })
        removeAlert.addAction(offAction)
        removeAlert.addAction(onAction)
        removeAlert.addAction(removeAction) // 액션 추가
        
        present(removeAlert, animated: true, completion: nil)
    }
    
    @IBAction func switchLamp(isOnBtn: Bool){
        if(isOn == isOnBtn){
            let alert = UIAlertController(title: "경고", message: isOnBtn ? "이미 켜져있어요" : "이미 꺼져있어요", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title:"네, 알겠습니다", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: isOnBtn ? "램프 켜기" : "램프 끄기", message: isOnBtn ? "램프를 켤까요?" : "램프를 끌까요?", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title:"네", style: UIAlertAction.Style.default, handler: {
                ACTION in self.imageView.image = isOnBtn ? self.imageOn : self.imageOff
                self.isOn = isOnBtn
            })
            let offAction = UIAlertAction(title:"아니오", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(onAction)
            alert.addAction(offAction)
            present(alert, animated: true, completion: nil)
        }
    }
}

