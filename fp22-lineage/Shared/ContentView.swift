//
//  ContentView.swift
//  Shared
//
//  Created by Jackson Dowden on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    
    
    @StateObject var CC = ClosetController()
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CarouselView(CC: CC)
                .tabItem {
                    Label("Make Outfit", systemImage: "house")
                }
                .tag(1)
            
            NewPictureView(CC: CC)
                .tabItem {
                    Label("Add Clothing", systemImage: "plus")
                }
                .tag(2)
        }
        .onChange(of: selectedTab) { newValue in
            CC.getCloset()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
