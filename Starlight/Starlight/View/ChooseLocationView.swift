//
//  ChooseLocationView.swift
//  Starlight
//
//  Created by 원주연 on 8/11/24.
//

import SwiftUI

struct ChooseLocationView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                MapTestView().ignoresSafeArea()
                VStack{
                    Spacer()
                    ChooseLocation
                        .padding(.bottom, 9)
                }
                .padding(.horizontal, 16)
                .toolbar {
                    ToolbarItem(placement: .principal){
                        Text("경주월드")
                            .font(.title3)
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.white, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    @ViewBuilder
    var LocationTitle: some View {
        Text("경주월드")
    }
    
    @ViewBuilder
    var ChooseLocation: some View {
        VStack(alignment: .leading) {
            Text("경주월드")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
                Image("LocatePin")
                Text("경북 경주시 보문로 544")
            }
            .padding(.bottom)
            Button(action: {
                // 버튼 눌렀을 때 실행될 기능
            },
                   label: {
                RoundedRectangle(cornerRadius: 99)
                    .stroke(.orange)
                    .overlay{
                        Text("도착지로 선택")
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                    }
                
            }).frame(maxHeight: 48)
        }
        .padding(24)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ChooseLocationView()
}
