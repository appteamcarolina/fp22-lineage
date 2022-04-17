//
//  CarouselView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct CarouselView: View {
    @StateObject var vm = CarouselViewModel()
    @State var index = 0

    var body: some View {
        VStack {
            Button {
                vm.getCloset()
            } label: {
                Text("Update Closet")
            }
            HStack {
                Button {
                    index -= 1
                    index = index%vm.Closet.count
                } label: {
                    Image(systemName: "plus")
                }
                ZStack {
                    if (vm.Closet.count == 0) {
                        Text("No clothing")
                    } else {
                        Image(uiImage: vm.Closet[index].image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(vm.Closet[0].border)
                            .border(Color.red, width: 2)
                    }
                }
                Button {
                    index += 1
                    index = index%vm.Closet.count
                } label: {
                    Image(systemName: "plus")
                }
            }
            Button {
                vm.clearCloset()
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
