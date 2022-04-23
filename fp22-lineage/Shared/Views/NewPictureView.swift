//
//  NewPictureView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct NewPictureView: View {
        
    @StateObject var vm: NewPictureViewModel = NewPictureViewModel()
    @State var showPreview: Bool = false
    
    @Binding var selected: Bool
    
    @ObservedObject var CC: ClosetController
    @Binding var selectedTab: Int
    @State var clothing: Clothing
    
    init(CC: ClosetController, selectedTab: Binding<Int>, clothing: Clothing, selected: Binding<Bool>) {
        self.CC = CC
        self._selectedTab = selectedTab
        self.clothing = clothing
        self._selected = selected
    }
     
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Image(uiImage: clothing.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(clothing.border)
                    .frame(width: 378, height: 504)
                if clothing.photoChosen {
                    Canvas { context, size in
                        var path = Path()
                        path.addLines(vm.currentLine.points)
                        context.stroke(path, with: .color(Color.white), lineWidth: vm.currentLine.lineWidth)
                    }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        vm.changeDrawing(value: value)
                        })
                    .onEnded({ value in
                        vm.pauseDrawing()
                    })
                    )
                    .frame(width: 378, height: 504)
                }
            }
            HStack {
                Button {
                    vm.undo()
                } label: {
                    Label("Undo", systemImage: "arrowshape.turn.up.backward.fill")
                }
                Spacer()
                Button {
                    clothing = vm.resetDrawing(clothing: clothing)
                } label: {
                    Label("Clear", systemImage: "xmark")
                }
                Spacer()
                /*
                Button {
                    clothing = Clothing(mult: 1, line: defaultLine)
                    clothing = vm.resetDrawing(clothing: clothing)
                    selected = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Circle())
                        .padding(2)
                }
                 */
                Button {
                    clothing = vm.endDrawing(clothing: clothing)
                    showPreview = true
                } label: {
                    Label("Save", systemImage: "checkmark")
                }
            }.frame(width:340)
            Text("Use your finger to outline your item of clothing")
            Spacer()
        }
        /*
        .onDisappear {
            selectedTab = 1
        }
        */
        .sheet(isPresented: $showPreview, onDismiss: {
            selected = false
            selectedTab = 1
            CC.saveCloset()
        }) {
            PreviewView(CC: CC, clothing: clothing, selectedTab: $selectedTab, showPreview: $showPreview)
        }
    }
}
