//
//  ContentView.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                NavigationLink(destination: ChooseLocationView(),
                               label: {
                    Text("go to ChooseLacationView")
                })
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
