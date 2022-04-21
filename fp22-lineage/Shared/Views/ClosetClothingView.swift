//
//  ClosetClothingView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/21/22.
//

import SwiftUI

struct ClosetClothingView: View {
    
    @ObservedObject var CC: ClosetController
    @State var clothing: Clothing
    
    init(CC: ClosetController, clothing: Clothing) {
        self.CC = CC
        self.clothing = clothing.updateMult(mult: 0.3)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: clothing.image)
                .resizable()
                .scaledToFill()
                .clipShape(clothing.border)
                .frame(width: clothing.width, height: clothing.height)
                .border(Color.black, width: 1)
            Button {
                CC.deleteClothing(clothing: clothing)
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Circle())
                    .padding(5)
            }

        }
    }
}
