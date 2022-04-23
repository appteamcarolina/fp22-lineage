//
//  ContentView.swift
//  Shared
//
//  Created by Jackson Dowden on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var CC = ClosetController()
    
    @State private var selectedTab = 1
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            CarouselView(CC:CC, selectedTab: $selectedTab)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(1)
            PictureSettingsView(CC:CC, selectedTab: $selectedTab)
                .tabItem {
                    VStack {
                        Image(systemName: "camera.fill")
                        Text("Add Clothing")
                    }
                }
                .tag(2)
            ClosetView(CC:CC, selectedTab: $selectedTab)
                .tabItem {
                    VStack {
                        Image(systemName: "tshirt")
                        Text("Closet")
                    }
                }
                .tag(3)
        }
        .accentColor(Color.black)
    }
}
