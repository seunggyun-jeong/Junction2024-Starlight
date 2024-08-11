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
                        Text("Jukdo Market")
                            .font(.system(size: 20, weight: .medium))
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
        Text("Jukdo Market")
            .font(.system(size: 16))
    }
    
    @ViewBuilder
    var ChooseLocation: some View {
        VStack(alignment: .leading) {
            Text("Jukdo Market")
                .font(.system(size: 20))
                .fontWeight(.semibold)
            HStack {
                Image("LocatePin")
                Text("13 Jukdosijang 13-gil, Buk-gu, Pohang-si")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: 0x777777))
            }
            .padding(.bottom)
            Button(action: {
                // 버튼 눌렀을 때 실행될 기능
            },
                   label: {
                RoundedRectangle(cornerRadius: 99)
                    .stroke(Color(hex: 0xFF7A00))
                    .overlay{
                        Text("Set as Destination")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(hex: 0xFF7A00))
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
