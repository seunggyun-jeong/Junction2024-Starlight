//
//  MainView.swift
//  Starlight
//
//  Created by 원주연 on 8/10/24.
//

import SwiftUI
import MapKit

struct MainView: View {
  @State var destination: String = "어디로 가세요?"
  @State var selectPoint: CLLocationCoordinate2D?
  let mapViewModel = MapViewModel()
  
  var body: some View {
    ZStack{
      MapView(selectPoint: $selectPoint).ignoresSafeArea()
      
      VStack{
        SearchRootBox
          .padding(.top, 21)
        Spacer()
        HStack{
          EmergencyButton
          Spacer()
          Image("CurrentLocationImage")
        }
        .padding(.bottom, 9)
        if selectPoint != nil {
          destinationInfo
        } else {
          LocationInfo
            .padding(.bottom,3)
        }
        
      }
      .padding(.horizontal, 16)
    }
  }
  
  @ViewBuilder
  var SearchRootBox: some View {
    RoundedRectangle(cornerRadius: 16)
      .fill(Color.white)
      .stroke(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
      .frame(maxHeight: 52)
      .overlay {
        HStack{
          Image("LOGOImage")
            .frame(width: 15, height: 20)
            .padding(.trailing, 5)
          TextField("어디로 가세요?", text: $destination)
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(Color.gray)
          Spacer()
        }.padding()
      }
  }
  
  @ViewBuilder
  var EmergencyButton: some View {
    RoundedRectangle(cornerRadius: 99)
      .foregroundStyle(Color.orange)
      .frame(maxWidth: 126, maxHeight: 40)
      .overlay{
        HStack{
          Image(systemName: "sos.circle")
          Text("Emergency")
            .font(.caption2)
            .fontWeight(.bold)
        }.padding().foregroundStyle(.white)
      }
  }
  
  var destinationInfo: some View {
    VStack(alignment: .leading) {
      HStack{
        Text("Destination")
          .font(.title2)
          .fontWeight(.semibold)
        Spacer()
      }
      .padding(.bottom, 16)
      
      HStack {
        Image("LocatePin")
          .padding(.trailing, 8)
        if let lat = selectPoint?.latitude, let lon = selectPoint?.longitude {
          Text("\(lat), \(lon)")
        }
      }
      .padding(.bottom, 24)
      
      NavigationLink {
        if let lat = selectPoint?.latitude, let lon = selectPoint?.longitude {
          RecommendRouteView(directionText: String(format: "%.4f, %.4f", lat, lon), lat: lat, lon: lon, mapViewModel: mapViewModel)
        }
      } label: {
        RoundedRectangle(cornerRadius: 99)
          .stroke(lineWidth: 1.0)
          .foregroundStyle(Color.orange)
          .frame(maxHeight: 48)
          .overlay{
            HStack{
              Text("Set as Destination")
                .font(.headline)
            }.padding().foregroundStyle(.orange)
          }
      }
      
      
    }
    .padding(24)
    .background(Color.white, in: RoundedRectangle(cornerRadius: 16))
  }
  
  @ViewBuilder
  var LocationInfo: some View {
    VStack{
      HStack{
        Text("JukDo Police Station")
          .font(.title2)
          .fontWeight(.semibold)
        Spacer()
        Image(systemName: "dot.scope").foregroundStyle(.gray)
        Text("내 위치").foregroundStyle(.gray)
      }
      .padding(.bottom)
      HStack {
        Image("SafeLevel")
        Text("Safe level")
        Image("SafeLevel1")
        Spacer()
      }
      HStack(alignment: .top) {
        Image("LocatePin")
        Text("3-1, Jukdo-ro 68beon-gil, Buk-gu, Pohang-si")
        Spacer()
      }
    }
    .padding(24)
    .background(Color.white, in: RoundedRectangle(cornerRadius: 16))
  }
  
}

#Preview {
  NavigationStack {
    MainView()    
  }
}
