//
//  MainView.swift
//  Starlight
//
//  Created by 원주연 on 8/10/24.
//

import SwiftUI

struct MainView: View {
    @State var destination: String = "어디로 가세요?"
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            
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
                LocationInfo
                    .padding(.bottom,3)
                
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
                    Text("긴급 신고")
                        .font(.headline)
                        .fontWeight(.bold)
                }.padding().foregroundStyle(.white)
            }
    }
    
    @ViewBuilder
    var LocationInfo: some View {
        VStack{
            HStack{
                Text("별빛 공원")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "dot.scope").foregroundStyle(.gray)
                Text("내 위치").foregroundStyle(.gray)
            }
            .padding(.bottom)
            HStack {
                Image("SafeLevel")
                Text("세이프 레벨")
                Image("SafeLevel1")
                Spacer()
            }
            HStack {
                Image("LocatePin")
                Text("경북 경주시 별빛동 211-5")
                Spacer()
            }
        }
        .padding(24)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 16))
    }
    
}

#Preview {
    MainView()
}
