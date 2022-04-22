//
//  ClosetView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/20/22.
//

import SwiftUI

struct ClosetView: View {
    
    @ObservedObject var CC: ClosetController
    @Binding var selectedTab: Int
    
    init(CC: ClosetController, selectedTab: Binding<Int>) {
        self.CC = CC
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: TypeView(CC:CC, type: "Hats")) {
                    Text("Hats")
                }
                NavigationLink(destination: TypeView(CC:CC, type: "Jackets")) {
                    Text("Jackets")
                }
                NavigationLink(destination: TypeView(CC:CC, type: "Tops")) {
                    Text("Tops")
                }
                NavigationLink(destination: TypeView(CC:CC, type: "Bottoms")) {
                    Text("Bottoms")
                }
                NavigationLink(destination: TypeView(CC:CC, type: "Shoes")) {
                    Text("Shoes")
                }
                Button {
                    CC.clearCloset()
                } label: {
                    Text("Clear Closet")
                        .padding()
                }
                Button {
                    CC.resetDummy()
                } label: {
                    Text("Reset Dummy")
                }
            }
        }
    }
}
