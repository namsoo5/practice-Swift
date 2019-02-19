//
//  ViewController.swift
//  prac_Map2
//
//  Created by 남수김 on 19/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit
import NMapsMap


class ViewController: UIViewController, NMFMapViewDelegate, CLLocationManagerDelegate {
    var mapView: NMFMapView!
    let locationManager = CLLocationManager()  //위치관리객체
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 정확도정도설정
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 권한 요청
        locationManager.distanceFilter = 50  //해당 거리마다 업뎃
        locationManager.startUpdatingLocation()  //위치정보 업데이트시작
        let la = self.locationManager.location?.coordinate.latitude
        let lo = self.locationManager.location?.coordinate.longitude
        print("la: \(String(describing: la!)), lo: \(String(describing: lo!))")
        
    
    }
    
    
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("delegate >> \(latlng.lat), \(latlng.lng)")
        
        let cameraupdate = NMFCameraUpdate(scrollTo: latlng)  //지도 카메라중심을 해당위치로전환
        mapView.moveCamera(cameraupdate) // 지도업데이트
    }
    
    // didTapMapView 로 기능 대체
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        let touch = touches.first!.location(in: touches.first!.view)  //터치된 위치가져옴
    //
    //        let projection = mapView.projection  //화면좌표와 지도좌표간의 전환
    //        let pos = projection.latlng(from: CGPoint(x: touch.x, y: touch.y))  //화면상 터치된위치를 지도의 좌표로전환
    //        print("터치 >> 위도: \(pos.lat), 경도: \(pos.lng)")
    //
    //        let cameraupdate = NMFCameraUpdate(scrollTo: pos)  //지도 카메라중심을 해당위치로전환
    //        mapView.moveCamera(cameraupdate) // 지도업데이트
    //    }
    
    
    //위치변화시 업데이트 -> 현위치로 지도카메라 이동
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locate = locations[locations.count-1]
        let lat = locate.coordinate.latitude
        let lng = locate.coordinate.longitude
        print("위도: \(lat) 경도: \(lng)")
        let latlng = NMGLatLng(lat: lat, lng: lng)
        
        let cameraupdate = NMFCameraUpdate(scrollTo: latlng)
        mapView.moveCamera(cameraupdate)
        
        
        
    }
    
    //권한 승인시 맵불러옴
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
            OperationQueue.main.addOperation {
                
                self.mapView = NMFMapView(frame: self.view.frame)
                self.view.addSubview(self.mapView)
                self.mapView.delegate = self //delegate 설정
                
                let coord = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
                
                print("초기위치 >> 위도: \(coord.lat), 경도: \(coord.lng)")
            
                //let cameraPosition = mapView.cameraPosition  //카메라 현재위치
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error \(error.localizedDescription)")
    }
}

