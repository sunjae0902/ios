//
//  EditViewController.swift
//  navigation
//
//  Created by sunjae on 9/11/24.
//

import UIKit

protocol EditDelegate { // 상속받는 클래스가 구현해야 할 함수 선언
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoom(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate? // delegate 선언
    var isOn = false
    var isZoom = false
    
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var switchIsOn: UISwitch!
    @IBOutlet var lblISOn: UILabel!
    @IBOutlet var btnTitle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMessage.text = textMessage
        lblISOn.text = "전구"
        switchIsOn.isOn = isOn
        btnTitle.setTitle(isZoom ? "축소" : "확대", for: .normal)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if(delegate != nil){
            delegate?.didMessageEditDone(self, message: txtMessage.text!) // 수정 -> 메인으로 수정된 데이터 전달
            delegate?.didImageOffDone(self, isOn: isOn)
            delegate?.didImageZoom(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true) // pop함
        
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        isOn = sender.isOn
    }
    
    @IBAction func btnSetSize(_ sender: UIButton) {
        isZoom = !isZoom
        if(isZoom){
            sender.setTitle("축소", for: .normal)
        }else{
            sender.setTitle("확대", for: .normal)
        }
    }
}
