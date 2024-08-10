//
//  TestGeoView.swift
//  Starlight
//
//  Created by Yeji Seo on 8/11/24.
//

import SwiftUI



struct TestGeoView: View {


        @State private var inputText = "흥해공업고" // 기본 입력값을 "흥해공업고"로 설정
        @State private var placeName = ""
        @State private var address = ""
        @State private var longitude = ""
        @State private var latitude = ""
        @State private var errorMessage = ""

        var body: some View {
            VStack {
                TextField("장소 이름을 입력하세요", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("지오코딩 실행") {
                    NaverAPI.geocode(address: inputText) { result in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                self.placeName = inputText
                                self.address = data.0
                                self.longitude = data.1
                                self.latitude = data.2
                                self.errorMessage = ""
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.errorMessage = "Error: \(error.localizedDescription)"
                            }
                        }
                    }
                }
                .padding()
                
                TextField("위도 입력", text: $latitude)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            TextField("경도 입력", text: $longitude)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            Button("역지오코딩 실행") {
                                NaverAPI.reverseGeocode(latitude: latitude, longitude: longitude) { result in
                                    switch result {
                                    case .success(let address):
                                        DispatchQueue.main.async {
                                            self.address = address
                                            self.errorMessage = ""
                                        }
                                    case .failure(let error):
                                        DispatchQueue.main.async {
                                            self.errorMessage = "Error: \(error.localizedDescription)"
                                        }
                                    }
                                }
                            }
                            .padding()

                
                if !placeName.isEmpty && !longitude.isEmpty && !latitude.isEmpty && !address.isEmpty {
                    Text("장소: \(placeName)")
                    Text("주소: \(address)")
                    Text("경도 (x): \(longitude)")
                    Text("위도 (y): \(latitude)")
                } else if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                
                
                
            }
            .padding()
        }
    }

    #Preview {
        TestGeoView()
    }
