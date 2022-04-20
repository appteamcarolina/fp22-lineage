//
//  CarouselView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct CarouselView: View {
    
    @StateObject var vm = CarouselViewModel()
    @State private var newPic = false
    
    @ObservedObject var CC: ClosetController
    @Binding var selectedTab: Int
    
    init(CC: ClosetController, selectedTab: Binding<Int>) {
        self.CC = CC
        self._selectedTab = selectedTab
    }
    
    var body: some View {

        VStack {
            ZStack {
                if (CC.Closet.count != 0) {
                    let clothing = CC.getClothing(index: vm.topIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                }
                HStack {
                    Button {
                        vm.changeTopIndex(val: -1, len: CC.Closet.count)
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                    Spacer()
                        .frame(width:200)
                    Button {
                        vm.changeTopIndex(val: 1, len: CC.Closet.count)
                    } label: {
                        Image(systemName: "arrow.right")
                    }
                }
            }.frame(width: 420, height: 560)
            Button {
                CC.clearCloset()
                vm.resetTopIndex()
            } label: {
                Text("Clear Closet")
            }
        }
    }
}
