//
//  MapViewModel.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation
import MapKit

@Observable
class MapViewModel {
  var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  )
  
  var annotations: [Place] = []
  var route: MKRoute?
  
  private let startCoordinate = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780) // 서울
  private let endCoordinate = CLLocationCoordinate2D(latitude: 35.1796, longitude: 129.0756) // 부산
  
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
        
        point.annotations = [
          Place(name: "Start", coordinate: point.startCoordinate),
          Place(name: "End", coordinate: point.endCoordinate)
        ]
      }
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
