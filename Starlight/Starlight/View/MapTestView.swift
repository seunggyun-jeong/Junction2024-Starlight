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
  @State private var position = MapCameraPosition.region(.init(center: .init(latitude: 36.0271, longitude: 129.3631), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
  
  private var viewModel = MapViewModel()
  
  var body: some View {
    Button(action: locationManager.requestLocation, label: {
      Text("Button")
    })
    
    Map(position: $position, interactionModes: [.zoom, .pan]) {
      ForEach(SharedModel.shared.dawnSafetyInfo, id: \.geohash) { info in
        
        MapCircle(center: Geohash.decode(info.geohash), radius: 570)
          .foregroundStyle(info.grade.color.opacity(0.4))
      }
      
      ForEach(SharedModel.shared.cctvInfo, id: \.number) { cctv in
        let longitude = cctv.longitude as NSString
        let latitude = cctv.latitude as NSString
        
        Annotation("", coordinate: CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)) {
          Circle()
            .foregroundStyle(.red)
            
        }
      }
      
      if let route = viewModel.route {
        MapPolyline(coordinates: [])
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
