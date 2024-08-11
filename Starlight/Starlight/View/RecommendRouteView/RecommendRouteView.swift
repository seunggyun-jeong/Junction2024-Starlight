//
//  RecommendRouteView.swift
//  Starlight
//
//  Created by 원주연 on 8/11/24.
//

import SwiftUI
import MapKit

struct RecommendRouteView: View {
  @State private var isCCTVSelected: Bool = false
  @State private var isLampSelected: Bool = false
  @State private var isPoliceSelected: Bool = false
  
  @State var inputText = "JukDo Police Station"
  @State var directionText = ""
  @State var items = [String]()
  
  let lat: Double
  let lon: Double
  
  @Bindable var mapViewModel: MapViewModel
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      MapTestView(viewModel: mapViewModel).ignoresSafeArea()
      
      VStack{
        //검색 뷰 붙여넣기
        VStack(alignment: .leading) {
          Button(action: { dismiss() }, label: {
            BackButton()
              .padding(.bottom, 16)
          })
          .tint(.primary)

          SearchBar(
            iconName: "mageLocation",
            placeholder: "Search Current Location",
            text: $inputText,
            backgroundColor: .white
          )
          .padding(.bottom, 8)
          
          SearchBar(
            iconName: "IconLocationPin",
            placeholder: "Search Destination",
            text: $directionText,
            backgroundColor: Color(hex: 0xf3f3f3)
          )
          .padding(.bottom, 8)
        }
        .padding(.horizontal, 16)
        .background(.white)
        
        HStack {
          // CCTV 버튼
          Button(action: {
            mapViewModel.cctvVisibility.toggle()
          },
                 label: {
            HStack{
              Image(mapViewModel.cctvVisibility ? "Icon_CCTV_white" :"Icon_CCTV")
              Text("CCTV")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(mapViewModel.cctvVisibility ? .white : .black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(mapViewModel.cctvVisibility ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
          })
          // 가로등 버튼
          Button(action: {
            mapViewModel.lampVisibility.toggle()
          },
                 label: {
            HStack{
              Image(mapViewModel.lampVisibility ? "Icon_WallLamp_white" : "Icon_walllamp")
              Text("Streetlight")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(mapViewModel.lampVisibility ? .white : .black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(mapViewModel.lampVisibility ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
          })
          // 경찰서 버튼
          Button(action: {
            mapViewModel.policeStationVisibility.toggle()
          },
                 label: {
            HStack{
              Image(mapViewModel.policeStationVisibility ? "Icon_PoliceBadge_white" :"Icon_PoliceBadge")
              Text("Police")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(mapViewModel.policeStationVisibility ? .white : .black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(mapViewModel.policeStationVisibility ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
          })
        }.padding(.horizontal, 16)
        Spacer()
        RootInfo.padding(.horizontal, 16)
      }/*.padding(.horizontal, 16)*/
      .navigationBarBackButtonHidden()
      .onAppear {
        mapViewModel.getDirections(start: .init(latitude: 36.0271, longitude: 129.3631), end: .init(latitude: lat, longitude: lon))
      }
    }
  }
  
  @ViewBuilder
  var RootInfo: some View {
    VStack(alignment: .leading) {
      Text("Safe Route")
        .foregroundStyle(.gray)
        .font(.callout)
        .fontWeight(.semibold)
      HStack(alignment: .bottom) {
        Text("\(Int(mapViewModel.route?.expectedTravelTime ?? 0) / 60)min")
          .font(.title2)
          .fontWeight(.semibold)
        Text("\(Int(mapViewModel.route?.distance ?? 0))m")
          .font(.footnote)
          .padding(.bottom, 3)
        
        Spacer()
        
        HStack {
          Image("Icon_CCTV")
            .foregroundStyle(.gray)
          Text("\(mapViewModel.cctvOnRoute.count)")
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(.quinary, in: RoundedRectangle(cornerRadius: 99))
        
        HStack{
          Image("Icon_walllamp")
            .foregroundStyle(.gray)
          Text("\(mapViewModel.lampOnRoute.count)")
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(.quinary, in: RoundedRectangle(cornerRadius: 99))
        
        HStack{
          Image("Icon_PoliceBadge")
            .foregroundStyle(.gray)
          Text("1")
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(.quinary, in: RoundedRectangle(cornerRadius: 99))
      }
      .padding(.bottom)
      Button(action: {
        // 버튼 눌렀을 때 실행될 기능
      },
             label: {
        RoundedRectangle(cornerRadius: 99)
              .foregroundStyle(Color(hex: 0xFF7A00))
          .overlay{
            Text("Follow Route")
              .fontWeight(.semibold)
              .foregroundStyle(.white)
          }
        
      }).frame(maxHeight: 48)
    }
    .padding(24)
    .background(.white, in: RoundedRectangle(cornerRadius: 16))
  }
  
}

#Preview {
  RecommendRouteView(lat: 116.0, lon: 55,mapViewModel: MapViewModel())
}
