//
//  MapView.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import MapKit
import SwiftUI

struct MapView: View {
  @State private var camera: MapCameraPosition = .region(MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // Seoul
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  ))
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // Seoul
    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  )
  @State private var geohash: String = ""
  @State private var annotations: [GeohashAnnotation] = []
  
  var body: some View {
    VStack {
      TextField("Enter Geohash", text: $geohash)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      
      Button("Show on Map") {
        let coordinate = Geohash.decode(geohash)
        let newRegion = MKCoordinateRegion(
          center: coordinate,
          span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        region = newRegion
        camera = .region(newRegion)
        annotations = [GeohashAnnotation(geohash: geohash, coordinate: coordinate)]
      }
      
      Map(position: $camera) {
        ForEach(annotations) { annotation in
          Marker(coordinate: annotation.coordinate) {
            Rectangle()
              .foregroundStyle(.red)
              .frame(width: 30)
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
  MapView()
}
