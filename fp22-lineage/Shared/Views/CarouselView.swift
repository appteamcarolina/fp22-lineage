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

    var body: some View {
        VStack {
            HStack {
                Button {
                    vm.changeShirtIndex(val: -1, len: CC.Closet.count)
                } label: {
                    Image(systemName: "arrow.left.circle")
                }
                ZStack {
                    if (CC.Closet.count == 0) {
                        Text("No clothing")
                    } else {
                        let clothing = CC.getClothing(index: vm.shirtIndex, mult: 0.5)
                        VStack {
                            Spacer()
                                .frame(height: 240)
                            Image("shorts")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 210, height: 280)
                        }
                        VStack {
                            Image(uiImage: clothing.image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(clothing.border)
                                .frame(width: 210, height: 280)
                            Spacer()
                                .frame(height: 240)
                        }
                    }
                }
                Button {
                    vm.changeShirtIndex(val: 1, len: CC.Closet.count)
                } label: {
                    Image(systemName: "arrow.right.circle")
                }
            }
            Button {
                CC.clearCloset()
                vm.resetShirtIndex()
            } label: {
                Text("Clear Closet")
            }
        }
    }
}

/*
struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(Closet: )
    }
}
 */
