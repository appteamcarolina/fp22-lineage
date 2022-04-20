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
        .navigationBarItems(leading: Image(systemName: "house"), trailing: NavigationLink(destination: NewPictureView(CC:CC)) { Image(systemName: "plus") })
        .navigationBarBackButtonHidden(true)
    }
}

/*
struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(Closet: )
    }
}
 */
