//
//  MapViewModel.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation
import MapKit
import SwiftUI

@Observable
class MapViewModel {
  var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  )
  
  var camera = MapCameraPosition.region(.init(center: .init(latitude: 36.0271, longitude: 129.3631), span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)))
  
  var annotations: [Place] = []
  var route: MKRoute?
  
  var cctvOnRoute: [CCTVInfo] = []
  var lampOnRoute: [SecurityLight] = []
  
  var cctvVisibility = false
  var policeStationVisibility = false
  var lampVisibility = false
  
  func getDirections(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
    request.transportType = .walking
    
    let directions = MKDirections(request: request)
    directions.calculate { [weak self] response, error in
      guard let point = self, let route = response?.routes.first else { return }
      
      DispatchQueue.main.async {
        point.route = route
        point.setRegionToFitRoute()
        
        point.cctvOnRoute = point.getCCTVsInRouteRange(route: route)
        point.lampOnRoute = point.getLampsInRouteRange(route: route)
        
        point.annotations = [
          Place(name: "Start", coordinate: start),
          Place(name: "End", coordinate: end)
        ]
      }
    }
  }
  
  func getCCTVsInRouteRange(route: MKRoute) -> [CCTVInfo] {
    let routeRect = route.polyline.boundingMapRect
    let expandedRect = routeRect.insetBy(dx: -10, dy: -10)  // 경로 주변 1km 확장
    
    return SharedModel.shared.cctvInfo.filter { cctv in
      guard let latitude = Double(cctv.latitude),
            let longitude = Double(cctv.longitude) else {
        return false
      }
      
      let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      let mapPoint = MKMapPoint(coordinate)
      return expandedRect.contains(mapPoint)
    }
  }
  
  func getLampsInRouteRange(route: MKRoute) -> [SecurityLight] {
    let routeRect = route.polyline.boundingMapRect
    let expandedRect = routeRect.insetBy(dx: -10, dy: -10)  // 경로 주변 1km 확장
    
    return SharedModel.shared.securityLights.filter { cctv in
      guard let latitude = Double(cctv.latitude),
            let longitude = Double(cctv.longitude) else {
        return false
      }
      
      let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      let mapPoint = MKMapPoint(coordinate)
      return expandedRect.contains(mapPoint)
    }
  }
  
  private func setRegionToFitRoute() {
    guard let rect = route?.polyline.boundingMapRect else { return }
    region = MKCoordinateRegion(rect)
  }
}

struct Place: Identifiable {
  let id = UUID()
  let name: String
  let coordinate: CLLocationCoordinate2D
}
