//
//  ViewController.swift
//  Audio
//
//  Created by sunjae on 9/20/24.
//

import UIKit
import AVFoundation

enum State{
    case stop
    case pause
    case play
    case record
}

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL! // 사용할 오디오 파일명
    
    let MAX_VOLUME: Float = 10.0 // 최대 볼륨
    
    var progressTimer: Timer! // 타이머를 위한 변수
    let timePlayerSelector = #selector(ViewController.updatePlayTime)
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false
    
    let timeRecorderSelector = #selector(ViewController.updateRecordTime)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        audioFile = Bundle.main.url(forResource: "playlist", withExtension: "mp3")
        selectAudioFile()
        if !isRecordMode{
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else{
            initRecord()
        }
        
    }
    
    func selectAudioFile(){
        if !isRecordMode { // 녹음 모드가 아닐 경우 재생 파일
            audioFile = Bundle.main.url(forResource: "playlist", withExtension: "mp3")
        } else{
            // FileManager.default: singleton
            //  녹음 파일 가져오기
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    // 포맷, 음질, 비트율, 오디오 채널, 샘플률 설정
    func initRecord(){
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] as [String: Any]
        
        do{
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord: \(error)")
        }
        
        audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayerButtons(false, pause: false, stop: false)
        let session = AVAudioSession.sharedInstance() // 인스턴스 생성
        do { // 카테고리와 액티브 설정
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive: \(error)")
        }
    }
    
    func initPlay(){
        do{
            audioPlayer = try // 오류가 발생할 수 있는 메서드 앞에 try
            AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay: \(error)")
        }
        // 초기화
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayerButtons(true, pause: false, stop: false)
    }
    
    // 곡 시간을 00:00로 포맷팅하는 함수
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) // 나머지
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func setPlayerButtons(_ play: Bool, pause: Bool, stop: Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func setStatusLabel(_ state: State){
        switch state {
        case State.pause:
            lblStatus.text = "일시 정지"
        case State.play:
            lblStatus.text = "재생중"
        case State.record:
            lblStatus.text = "녹음중"
        default:
            lblStatus.text = "정지"
        }
    }
    
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
    
    func audioPlayerFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        progressTimer.invalidate()
        setPlayerButtons(true, pause: false, stop: false)
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        setStatusLabel(State.play)
        audioPlayer.play()
        setPlayerButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayerButtons(true, pause: false, stop: true)
        setStatusLabel(State.pause)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        setPlayerButtons(true, pause: true, stop: false)
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayerButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
        setStatusLabel(State.stop)
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else{
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
            lblRecordTime.isEnabled = false
        }
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        } else{
            initRecord()
        }
    }
    
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel??.text == "Record"{
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecorderSelector, userInfo: nil, repeats: true)
            setStatusLabel(State.record)
        } else{
            audioRecorder.stop()
            progressTimer.invalidate()
            setStatusLabel(State.stop)
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
            setStatusLabel(State.stop)
        }
    }
}

