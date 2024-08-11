//
//  MapTestView.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import SwiftUI
import MapKit

struct MapTestView: View {
  @StateObject private var locationManager = LocationManager()
  //  @State private var position = MapCameraPosition.userLocation(fallback: .automatic)
  @State private var position = MapCameraPosition.region(.init(center: .init(latitude: 36.0271, longitude: 129.3631), span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001)))
  
  @Bindable var viewModel = MapViewModel()
  
  var body: some View {
    Map(position: $viewModel.camera, interactionModes: [.zoom, .pan]) {
      if viewModel.cctvVisibility {
        ForEach(viewModel.cctvOnRoute, id: \.number) { cctv in
          let longitude = cctv.longitude as NSString
          let latitude = cctv.latitude as NSString
          
          Annotation("", coordinate: CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)) {
            Circle()
              .foregroundStyle(.red)
            
          }
        }
      }
      
      if viewModel.lampVisibility {
        ForEach(viewModel.lampOnRoute, id: \.locationName) { lamp in
          let longitude = lamp.longitude as NSString
          let latitude = lamp.latitude as NSString
          
          Annotation("", coordinate: CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)) {
            Circle()
              .foregroundStyle(.blue)
            
          }
        }
      }
      ForEach(SharedModel.shared.dawnSafetyInfo, id: \.geohash) { info in
        
        MapCircle(center: Geohash.decode(info.geohash), radius: 570)
          .foregroundStyle(info.grade.color.opacity(0.3))
      }
      

      
      if let route = viewModel.route {
        MapPolyline(route)
          .stroke(.blue, lineWidth: 5)
        
        ForEach(viewModel.annotations, id: \.id) { annotation in
          Annotation("", coordinate: annotation.coordinate) {
            Circle()
              .foregroundStyle(.red)
          }
        }
      }
    }
    .onAppear {
      locationManager.requestLocation()
    }
  }
}

enum SafetyGrade {
  case one
  case two
  case three
  case four
  case five
  
  var color: Color {
    switch self {
    case .one:
      Color.green
    case .two:
      Color.yellow
    case .three:
      Color.orange
    case .four:
      Color.red
    case .five:
      Color.purple
    }
  }
}

#Preview {
  MapTestView()
}
