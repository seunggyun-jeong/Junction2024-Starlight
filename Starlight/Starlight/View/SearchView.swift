//
//  SearchView.swift
//  Starlight
//
//  Created by Yeji Seo on 8/10/24.
//

//import SwiftUI

import SwiftUI

struct SearchView: View {
    @State var inputText = ""
    @State var directionText = ""
    @State var items = [String]()

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                BackButton()
                    .padding(.bottom, 14)

                SearchBar(
                    iconName: "star.fill",
                    placeholder: "현위치 검색",
                    text: $inputText,
                    backgroundColor: .white
                )
                .padding(.bottom, 12)

                SearchBar(
                    iconName: "star.fill",
                    placeholder: "도착지 검색",
                    text: $directionText,
                    backgroundColor: Color(hex: 0xf3f3f3)
                )
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 16)

            Divider()

            Text("최근 검색 위치")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color(hex: 0xAAAAAA))
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 0))

            RecentSearchList(items: $items)
        }
    }
}

struct BackButton: View {
    var body: some View {
        Circle()
            .fill(Color.white)
            .overlay(
                Image(systemName: "arrow.backward")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .padding(10)
            )
            .frame(width: 44, height: 44)
            .shadow(
                color: Color(hex: 0x333333).opacity(0.2),
                radius: CGFloat(0),
                x: CGFloat(0), y: CGFloat(0)
            )
    }
}

struct SearchBar: View {
    var iconName: String
    var placeholder: String
    @Binding var text: String
    var backgroundColor: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(backgroundColor)
            .overlay(
                HStack {
                    Image(systemName: iconName)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: -10))

                    ZStack(alignment: .leading) {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color(hex: 0x777777))
                                .padding(EdgeInsets(top: 14, leading: 10, bottom: 14, trailing: 16))
                        }
                        TextField("", text: $text)
                            .background(.clear)
                            .accentColor(Color(hex: 0x333333))
                            .padding(EdgeInsets(top: 14, leading: 12, bottom: 14, trailing: 16))
                    }
                }
            )
            .frame(height: 46)
            .shadow(
                color: Color(hex: 0x333333).opacity(0.2),
                radius: CGFloat(0),
                x: CGFloat(0), y: CGFloat(0)
            )
    }
}

struct RecentSearchItem: View {
    var title: String
    var subtitle: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(Color(hex: 0x333333))
                .padding(.vertical, 4)
            Text(subtitle)
                .font(.system(size: 16))
                .foregroundStyle(Color(hex: 0x777777))
                .padding(0)
        }
    }
}

struct RecentSearchList: View {
    @Binding var items: [String]

    var body: some View {
        List(items, id: \.self) { item in
            RecentSearchItem(title: "경주월드", subtitle: "경북 경주시 보문로 544")
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear {
            for number in 0..<50 {
                items.append("row \(number)")
            }
        }
    }
}

#Preview {
    SearchView()
}



