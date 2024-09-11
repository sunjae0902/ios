//
//  ViewController.swift
//  navigation
//
//  Created by sunjae on 9/11/24.
//

import UIKit

class ViewController: UIViewController, EditDelegate { // protocol 상속
    let imageOn = UIImage(systemName: "lightbulb")
    let imageOff = UIImage(systemName: "lightbulb.fill")
    var isOn = false
    var isZoom = false
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = isOn ? imageOn : imageOff
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // 세그웨이가 해당 뷰 컨트롤러로 전환되기 전 호출되는 함수
        let editViewController = segue.destination as! EditViewController // 세그웨이의 도착 컨트롤러 설정
        if(segue.identifier == "editButton"){
            editViewController.textWayValue = "seque: use button"
        } else if(segue.identifier == "editBarButton"){
            editViewController.textWayValue = "segue: use bar button"
        }
        editViewController.textMessage = txtMessage.text! // 메인 -> 수정
        editViewController.isOn = isOn // 메인의 전구 상태 값을 -> 수정 화면에 넘김 (동기화)
        editViewController.isZoom = isZoom
        editViewController.delegate = self
    }
    
    // 상속받은 프로토콜 메서드 구현(메시지 수정 후 실행할 코드)
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message
    }
    
    func didImageOffDone(_ controller: EditViewController, isOn: Bool) {
        self.isOn = isOn
        imageView.image = isOn ? imageOn : imageOff
    }
    
    func didImageZoom(_ controller: EditViewController, isZoom: Bool) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        self.isZoom = isZoom
        if(!isZoom){ // 축소
            newWidth = imageView.frame.width/scale
            newHeight = imageView.frame.height/scale
        }else{ // 확대
            newWidth = imageView.frame.width*scale
            newHeight = imageView.frame.height*scale
        }
        imageView.frame.size = CGSize(width: newWidth, height: newHeight)
    }
    


}

