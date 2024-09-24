//
//  ViewController.swift
//  cameraPhotoLibarary
//
//  Created by sunjae on 9/24/24.
//

import UIKit
import MobileCoreServices // ios 에서 사용할 데이터 타입 미리 정의

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL! // 녹화한 비디오의 url 저장
    var flagImageSave = false
    var numImage = 0
    
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnTakePhoto(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true // 이미지 저장 허용
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            numImage += 1
        }
        else {
            showAlert("Camera is not available", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadPhoto(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true // 수정 허용
            
            self.present(imagePicker, animated: true, completion: nil)
            numImage += 1
        }
        else {
            showAlert("Library is not available", message: "Application cannot access the photo library.")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: "public.image" as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            if numImage == 1 {
                topImageView.image = captureImage
            }
            else if numImage == 2 {
                leftImageView.image = captureImage
            }
            else if numImage == 3 {
                rightImageView.image = captureImage
            }
        }
//        else if mediaType.isEqual(to: "public.movie" as String) {
//            if flagImageSave {
//                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
//                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
//            }
//
//        }
        self.dismiss(animated: true, completion: nil) // 현재 이미지 피커 뷰를 제거하고 이전 뷰를 보여줌
    }
    // 취소할 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        numImage -= 1
    }
    
    func showAlert(_ title: String, message: String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @IBAction func btnInitAll(_ sender: UIButton) {
        topImageView.image = nil
        leftImageView.image = nil
        rightImageView.image = nil
    }
    
}

