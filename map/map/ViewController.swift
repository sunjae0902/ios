//
//  ViewController.swift
//  map
//
//  Created by sunjae on 9/8/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var lblLocation1: UILabel!
    @IBOutlet var lblLocation2: UILabel!
    @IBOutlet var myMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocation1.text = ""
        lblLocation2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 최고 설정
        locationManager.requestWhenInUseAuthorization() // 위치 권한 획득
        locationManager.startUpdatingLocation() // 위치 업데이팅
        
        myMapView.showsUserLocation = true
        
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longtitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtitudeValue) // 위,경도 값으로 위치 객체 생성
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 값을 넘겨 spanValue 값
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // 위치, 범위 값으로 region 객체 반환
        myMapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longtitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 100배 확대
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            print(placemarks!)
            let pm = placemarks!.first // placamarks의 첫 부분만 취함
            let country = pm!.country // 나라 값
            var address: String = country!
            
            if pm!.locality != nil {
                address += " "
                address += pm!.locality! // 지역값 추가
           }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare! // 도로값 추가
            }
            self.lblLocation1.text = "현재 위치"
            self .lblLocation2.text = address

        })
        locationManager.stopUpdatingLocation() // 업데이트 멈춤
    }
    
    func setAnnotaion(latitudeValue: CLLocationDegrees, longtitueValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubTitle: String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtitudeValue: longtitueValue, delta: span)
        
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        myMapView.addAnnotation(annotation)
    }

    @IBAction func sgmController(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            self.lblLocation1.text = ""
            self.lblLocation2.text = ""
            locationManager.startUpdatingLocation() // 현재 위치로 업데이트
            
        } else if(sender.selectedSegmentIndex == 1){
            setAnnotaion(latitudeValue: 37.495938823365, longtitueValue: 126.95437558238, delta: 0.01, title: "숭실대학교", subtitle: "서울시 동작구 상도로 369")
            self.lblLocation1.text = "보고 있는 위치"
            self.lblLocation2.text = "숭실대학교(서울시 동작구 상도로 369)"
            
        } else if(sender.selectedSegmentIndex == 2){
            setAnnotaion(latitudeValue: 37.593882286327, longtitueValue: 127.05271438629, delta: 0.01, title: "경희대학교 캠퍼스타운", subtitle: "서울특별시 동대문구 경희대로 26")
            self.lblLocation1.text = "보고 있는 위치"
            self.lblLocation2.text = "경희대학교 캠퍼스타운(서울특별시 동대문구 경희대로 26)"
            
        }
    }
    
    
    
}

