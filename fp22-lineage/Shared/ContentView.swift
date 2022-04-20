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
                    Text("Carousel")
                }
                .tag(1)
            NewPictureView(CC:CC, selectedTab: $selectedTab)
                .tabItem {
                    Text("New Picture")
                }
                .tag(2)
            ClosetView(CC:CC, selectedTab: $selectedTab)
                .tabItem {
                    Text("Closet")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
