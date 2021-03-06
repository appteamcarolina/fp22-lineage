//
//  TypeView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/21/22.
//

import SwiftUI

struct TypeView: View {
    
    @ObservedObject var CC: ClosetController
    var type: String
    
    @State var warning = false
    
    init(CC: ClosetController, type: String) {
        self.CC = CC
        self.type = type
    }
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height:100)
            Text("\(type)")
                .font(.title)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: items) {
                    switch type {
                    case "Hats":
                        ForEach(CC.Hats[1...], id: \.self) { Hat in
                            ClosetClothingView(CC: CC, clothing: Hat)
                        }
                    case "Jackets":
                        ForEach(CC.Jackets[1...], id: \.self) { Jacket in
                            ClosetClothingView(CC: CC, clothing: Jacket)
                        }
                    case "Tops":
                        ForEach(CC.Tops[1...], id: \.self) { Top in
                            ClosetClothingView(CC: CC, clothing: Top)
                        }
                    case "Bottoms":
                        ForEach(CC.Bottoms[1...], id: \.self) { Bottom in
                            ClosetClothingView(CC: CC, clothing: Bottom)
                        }
                    case "Shoes":
                        ForEach(CC.Shoes[1...], id: \.self) { Shoe in
                            ClosetClothingView(CC: CC, clothing: Shoe)
                        }
                    default:
                        Text("ERROR")
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            Button {
                warning = true
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                    Text("Clear \(type)")
                        .font(.headline)
                }
            }
            Spacer()
                .frame(height:30)
            .alert(isPresented: $warning) {
                Alert(
                    title: Text("Are you sure you want to clear your \(type)?"),
                    message: Text("You cannot undo this action"),
                    primaryButton: .destructive(Text("Clear")) {
                        CC.clearClothing(type: type)
                    },
                    secondaryButton: .cancel()
                )
            }
        }.edgesIgnoringSafeArea([.top])
    }
}
