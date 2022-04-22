//
//  PreviewView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/19/22.
//

import SwiftUI

struct PreviewView: View {
    
    @State private var location: CGPoint = CGPoint(x: 210, y: 280)
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
            }
    }

    @Binding var selectedTab: Int
    @Binding var showPreview: Bool
    
    @ObservedObject var CC: ClosetController
    @State var clothing: Clothing
    @State var mult: Double = 0.5
    var width: Double {
        get {
            mult * 378
        }
    }
    var height: Double {
        get {
            mult * 504
        }
    }
    var newClothing: Clothing {
        get {
            let intermediate = clothing.updateMult(mult: mult)
            return intermediate.updateLocation(location: location)
        }
    }
    
    init(CC: ClosetController, clothing: Clothing, selectedTab: Binding<Int>, showPreview: Binding<Bool>) {
        self.CC = CC
        self.clothing = clothing
        self._selectedTab = selectedTab
        self._showPreview = showPreview
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: CC.dummy.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 378, height: 504)
                Image(uiImage: newClothing.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(newClothing.border)
                    .frame(width: width, height: height)
                    .position(newClothing.location)
                    .gesture(simpleDrag)
            }.frame(width: 378, height: 504)
            HStack {
                Text("Adjust size with slider below!")
                    .font(.title3)
                Spacer()
                    .frame(width: 10)
                Button {
                    CC.addClothing(clothing: newClothing)
                    self.showPreview = false
                    self.selectedTab = 1
                } label: {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Circle())
                        .padding(2)
                }
            }
            Slider(value: $mult, in: 0.2...1.5)
        }
    }
}
