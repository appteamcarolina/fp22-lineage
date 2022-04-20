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
                Image("dummy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 420, height: 560)
                if (CC.Closet["Bottoms"]?.count != 0) {
                    let clothing = CC.getClothing(type: "Bottoms", index: vm.bottomsIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                        .position(clothing.location)
                }
                if (CC.Closet["Shoes"]?.count != 0) {
                    let clothing = CC.getClothing(type: "Shoes", index: vm.shoesIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                        .position(clothing.location)
                }
                if (CC.Closet["Top"]?.count != 0) {
                    let clothing = CC.getClothing(type: "Top", index: vm.topIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                        .position(clothing.location)
                }
                if (CC.Closet["Jacket"]?.count != 0) {
                    let clothing = CC.getClothing(type: "Jacket", index: vm.jacketIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                        .position(clothing.location)
                }
                if (CC.Closet["Hat"]?.count != 0) {
                    let clothing = CC.getClothing(type: "Hat", index: vm.hatIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                        .position(clothing.location)
                }
                VStack(spacing: 50) {
                    HStack {
                        Button {
                            vm.changeHatIndex(val: -1, len: CC.Closet["Hat"]!.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            vm.changeHatIndex(val: 1, len: CC.Closet["Hat"]!.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    HStack {
                        Button {
                            vm.changeJacketIndex(val: -1, len: CC.Closet["Jacket"]!.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            vm.changeJacketIndex(val: 1, len: CC.Closet["Jacket"]!.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    HStack {
                        Button {
                            vm.changeTopIndex(val: -1, len: CC.Closet["Top"]!.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            vm.changeTopIndex(val: 1, len: CC.Closet["Top"]!.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    HStack {
                        Button {
                            vm.changeBottomsIndex(val: -1, len: CC.Closet["Bottoms"]!.count)
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(Color.red)
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            vm.changeBottomsIndex(val: 1, len: CC.Closet["Bottoms"]!.count)
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color.red)
                        }
                    }
                    HStack {
                        Button {
                            vm.changeShoesIndex(val: -1, len: CC.Closet["Shoes"]!.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            vm.changeShoesIndex(val: 1, len: CC.Closet["Shoes"]!.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                }
            }.frame(width: 420, height: 560)
            Button {
                CC.clearCloset()
                vm.reset()
            } label: {
                Text("Clear Closet")
            }
        }
    }
}
