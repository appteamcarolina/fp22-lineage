//
//  ContentView.swift
//  Shared
//
//  Created by Jackson Dowden on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CarouselView()
                .tabItem {
                    Label("Make Outfit", systemImage: "house")
                }
            
            NewPictureView()
                .tabItem {
                    Label("Add Clothing", systemImage: "plus")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
