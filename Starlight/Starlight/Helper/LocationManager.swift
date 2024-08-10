//
//  LocationManager.swift
//  Starlight
//
//  Created by Gyunni on 8/11/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var camera = MapCameraPosition.region(MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 서울의 좌표
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  ))
  
  private let locationManager = CLLocationManager()
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
  }
  
  func requestLocation() {
    locationManager.requestLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    
    DispatchQueue.main.async {
      let region = MKCoordinateRegion(
        center: location.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      )
      print(region)
      self.camera = MapCameraPosition.region(region)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("위치를 가져오는데 실패했습니다: \(error.localizedDescription)")
  }
}
