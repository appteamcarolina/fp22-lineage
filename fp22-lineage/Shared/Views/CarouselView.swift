//
//  CarouselView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct CarouselView: View {
    
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
                if (CC.bottomsIndex != 0) {
                    let bottoms = CC.getClothing(type: "Bottoms", index: CC.bottomsIndex)
                    Image(uiImage: bottoms.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(bottoms.border)
                        .frame(width: bottoms.width, height: bottoms.height)
                        .position(bottoms.location)
                }
                if (CC.shoesIndex != 0) {
                    let shoes = CC.getClothing(type: "Shoes", index: CC.shoesIndex)
                    Image(uiImage: shoes.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(shoes.border)
                        .frame(width: shoes.width, height: shoes.height)
                        .position(shoes.location)
                }
                if (CC.topIndex != 0) {
                    let top = CC.getClothing(type: "Tops", index: CC.topIndex)
                    Image(uiImage: top.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(top.border)
                        .frame(width: top.width, height: top.height)
                        .position(top.location)
                }
                if (CC.jacketIndex != 0) {
                    let jacket = CC.getClothing(type: "Jackets", index: CC.jacketIndex)
                    Image(uiImage: jacket.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(jacket.border)
                        .frame(width: jacket.width, height: jacket.height)
                        .position(jacket.location)
                }
                if (CC.hatIndex != 0) {
                    let hat = CC.getClothing(type: "Hats", index: CC.hatIndex)
                    Image(uiImage: hat.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(hat.border)
                        .frame(width: hat.width, height: hat.height)
                        .position(hat.location)
                }
                VStack(spacing: 50) {
                    HStack {
                        Button {
                            CC.changeHatIndex(val: -1, len: CC.Hats.count)
                        } label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            CC.changeHatIndex(val: 1, len: CC.Hats.count)
                        } label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    HStack {
                        Button {
                            CC.changeJacketIndex(val: -1, len: CC.Jackets.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            CC.changeJacketIndex(val: 1, len: CC.Jackets.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    HStack {
                        Button {
                            CC.changeTopIndex(val: -1, len: CC.Tops.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            CC.changeTopIndex(val: 1, len: CC.Tops.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    HStack {
                        Button {
                            CC.changeBottomsIndex(val: -1, len: CC.Bottoms.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            CC.changeBottomsIndex(val: 1, len: CC.Bottoms.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    HStack {
                        Button {
                            CC.changeShoesIndex(val: -1, len: CC.Shoes.count)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                            .frame(width:300)
                        Button {
                            CC.changeShoesIndex(val: 1, len: CC.Shoes.count)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                }
            }.frame(width: 420, height: 560)
            Button {
                CC.clearCloset()
            } label: {
                Text("Clear Closet")
                    .padding()
            }
        }
    }
}
