//
//  RecommendRootView.swift
//  Starlight
//
//  Created by 원주연 on 8/11/24.
//

import SwiftUI

struct RecommendRootView: View {
    @State private var isCCTVSelected: Bool = false
    @State private var isLampSelected: Bool = false
    @State private var isPoliceSelected: Bool = false
    
    @State var inputText = ""
    @State var directionText = ""
    @State var items = [String]()
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack{
                //검색 뷰 붙여넣기
                VStack(alignment: .leading) {
                    BackButton()
                        .padding(.bottom, 16)

                    SearchBar(
                        iconName: "star.fill",
                        placeholder: "현위치 검색",
                        text: $inputText,
                        backgroundColor: .white
                    )
                    .padding(.bottom, 8)

                    SearchBar(
                        iconName: "star.fill",
                        placeholder: "도착지 검색",
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
                            Text("가로등")
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
                            Text("경찰서")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(isPoliceSelected ? .white : .black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isPoliceSelected ? .orange : .white, in: RoundedRectangle(cornerRadius: 99))
                    })
                }.padding(.horizontal, 16)
                Spacer()
                RootInfo.padding(.horizontal, 16)
            }/*.padding(.horizontal, 16)*/
        }
    }
    
    @ViewBuilder
    var RootInfo: some View {
        VStack(alignment: .leading) {
            Text("안심 경로")
                .foregroundStyle(.gray)
                .font(.callout)
                .fontWeight(.semibold)
            HStack {
                Text("13min")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("859m")
                    .font(.footnote)
                Spacer()
                HStack{
                    Image("Icon_CCTV")
                        .foregroundStyle(.gray)
                    Text("2")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.quinary, in: RoundedRectangle(cornerRadius: 99))
                HStack{
                    Image("Icon_WallLamp")
                        .foregroundStyle(.gray)
                    Text("6")
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
                    .foregroundStyle(.orange)
                    .overlay{
                        Text("따라가기")
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
    RecommendRootView()
}
