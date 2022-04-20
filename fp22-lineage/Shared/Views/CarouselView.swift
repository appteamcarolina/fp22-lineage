//
//  CarouselView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct CarouselView: View {
    
    @ObservedObject var CC : ClosetController
    @StateObject var vm = CarouselViewModel()
    @State private var newPic = false
    
    init(CC: ClosetController) {
        self.CC = CC
    }

    var body: some View {
        VStack {
            ZStack {
                if (CC.Closet.count == 0) {
                    Text("No clothing")
                } else {
                    let clothing = CC.getClothing(index: vm.shirtIndex)
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: clothing.width, height: clothing.height)
                }
                HStack {
                    Spacer()
                        .frame(width: 20)
                    Button {
                        vm.changeShirtIndex(val: -1, len: CC.Closet.count)
                    } label: {
                        Image(systemName: "arrow.left.circle")
                    }
                    Spacer()
                    Button {
                        vm.changeShirtIndex(val: 1, len: CC.Closet.count)
                    } label: {
                        Image(systemName: "arrow.right.circle")
                    }
                    Spacer()
                        .frame(width: 20)
                }
            }.frame(width: 420, height: 560)
            Button {
                CC.clearCloset()
                vm.resetShirtIndex()
            } label: {
                Text("Clear Closet")
            }
        }
        .background(
            NavigationLink(destination: NewPictureView(CC:CC), isActive: $newPic) {
                  EmptyView()
                }
            )
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Image(systemName: "house")
            }
            ToolbarItem(placement: ToolbarItemPlacement.principal) {
                Button {
                    self.newPic = true
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
