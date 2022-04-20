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
        Text("Closet")
    }
}
