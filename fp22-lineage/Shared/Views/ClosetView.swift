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
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 3)
        
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: items) {
                ForEach(CC.Hats[1...], id: \.self) { hat in
                    ClosetClothingView(CC: CC, clothing: hat)
                }
            }
            .padding(.horizontal)
        }
    }
}
