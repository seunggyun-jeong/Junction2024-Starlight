//
//  MapView.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import MapKit
import SwiftUI

struct MapView: View {
  @State private var camera = MapCameraPosition.region(.init(center: .init(latitude: 36.0271, longitude: 129.3631), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
  
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // Seoul
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  )
  
  @Binding var selectPoint: CLLocationCoordinate2D?
  
  @State private var annotations: [GeohashAnnotation] = [.init(geohash: "wy7wrz", coordinate: .init(latitude: 36.0271, longitude: 129.3631))]
  
  var body: some View {
    VStack {
      MapReader { proxy in
        Map(position: $camera, interactionModes: [.zoom, .pan]) {
          
          ForEach(annotations) { annotation in
            Annotation("", coordinate: annotation.coordinate) {
              Circle()
                .foregroundStyle(.blue)
                .frame(width: 15)
            }
          }
          
          if let selectPoint {
            Marker("", coordinate: selectPoint)
          }
        }
        .onTapGesture(coordinateSpace: .local) { location in
          if let coordinate: CLLocationCoordinate2D = proxy.convert(location, from: .local) {
            selectPoint = coordinate
          }
        }
      }
    }
  }
}

struct GeohashAnnotation: Identifiable {
  let id = UUID()
  let geohash: String
  let coordinate: CLLocationCoordinate2D
}


#Preview {
  MapView(selectPoint: .constant(.init(latitude: 36.0271, longitude: 129.3631)))
}
