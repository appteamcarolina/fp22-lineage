//
//  PreviewView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/19/22.
//

import SwiftUI

struct PreviewView: View {
    @ObservedObject var CC: ClosetController
    @State var clothing: Clothing
    @State var mult: Double = 0.5
    var width: Double {
        get {
            mult * 420
        }
    }
    var height: Double {
        get {
            mult * 560
        }
    }
    var newClothing: Clothing {
        get {
            clothing.updateMult(mult: mult)
        }
    }
    
    init(CC: ClosetController, clothing: Clothing) {
        self.CC = CC
        self.clothing = clothing
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: newClothing.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(newClothing.border)
                    .frame(width: width, height: height)
            }.frame(width: 420, height: 560)
            HStack {
                Text("Adjust size using slider")
                    .font(.title3)
                Spacer()
                    .frame(width: 20)
                NavigationLink(destination: CarouselView(CC: CC).onAppear {
                    CC.addClothing(clothing: newClothing)
                }) {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Circle())
                        .padding(2)
                }
                /*
                NavigationLink(destination: CarouselView(CC: CC)) {
                    Button {
                        CC.addClothing(clothing: newClothing)
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .clipShape(Circle())
                            .padding(2)
                    }
                }
                 */
                /*
                Button {
                    CC.addClothing(clothing: newClothing)
                } label: {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Circle())
                        .padding(2)
                }
                */
            }
            Slider(value: $mult, in: 0.3...1.2)
                .padding(5)
        }
    }
}

/*
struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
 */
