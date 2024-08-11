//
//  FollowSafeRouteView.swift
//  Starlight
//
//  Created by 원주연 on 8/11/24.
//

import SwiftUI

struct FollowSafeRouteView: View {
    @State private var isCCTVSelected: Bool = false
    @State private var isLampSelected: Bool = false
    @State private var isPoliceSelected: Bool = false
    @State private var isSOSTapped: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                VStack() {
                    ZStack{
                        HStack(alignment: .center){
                            Spacer()
                            Button(action: {},
                                   label: {
                                Image(systemName: "xmark")
                            })
                        }
                        .padding(.trailing, 20)
                        HStack(alignment:.center) {
                            Text("Safe Route")
                                .font(.title3)
                        }
                    }
                    .padding(4)
                    .padding(.top)

                    SafeRouteBox
                        .padding()
                    .padding(.bottom, 8)
                }
                .background(.white)
                
                
                HStack {
                    // CCTV 버튼
                    Button(action: {
                        isCCTVSelected.toggle()
                    },
                           label: {
                        HStack{
                            Image(isCCTVSelected ? "Icon_CCTV_white" :"Icon_CCTV")
                            Text("CCTV")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(isCCTVSelected ? .white : .black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isCCTVSelected ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
                    })
                    // 가로등 버튼
                    Button(action: {
                        isLampSelected.toggle()
                    },
                           label: {
                        HStack{
                            Image(isLampSelected ? "Icon_WallLamp_white" :"Icon_WallLamp")
                            Text("Streetlight")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(isLampSelected ? .white : .black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isLampSelected ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
                    })
                    // 경찰서 버튼
                    Button(action: {
                        isPoliceSelected.toggle()
                    },
                           label: {
                        HStack{
                            Image(isPoliceSelected ? "Icon_PoliceBadge_white" :"Icon_PoliceBadge")
                            Text("Police")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(isPoliceSelected ? .white : .black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isPoliceSelected ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
                    })
                }.padding(16)
                Spacer()
                
                HStack{
                    Button(action: {
                        isSOSTapped = true
                    },
                           label: {
                        HStack{
                            Image(systemName: "sos.circle")
                            isSOSTapped ? Text("Emergency Call").fontWeight(.medium) : nil
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .background(.orange, in: RoundedRectangle(cornerRadius: 99))
                    })
                    Spacer()
                    Image("SafeLevel")
                    Text("Safety Rating")
                    Image("SafeLevel1")
                }
                .padding(16)
            }
        }
    }
    
    @ViewBuilder
    var SafeRouteBox: some View {
        HStack {
            Text("Start")
                .foregroundStyle(.orange)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(.white, in: RoundedRectangle(cornerRadius: 16))
            
            Text("Jukdo-dong, Buk-gu, Pohang-si 어쩌구저쩌구")
                .foregroundStyle(.white)
                .fontWeight(.bold)
        }
        .padding(24)
        .background(.orange, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    FollowSafeRouteView()
}
