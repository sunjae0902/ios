//
//  ViewController.swift
//  moviePlayer
//
//  Created by sunjae on 9/21/24.
//

import UIKit
import AVKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInAppMovie(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: // 경로 받아오기
                                                 "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!) // url객체로 변환
        playVideo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        playVideo(url: url)
    }
    
    private func playVideo(url: NSURL){
        // controller, player 인스턴스 생성
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        // 재생 (화면 전환)
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

