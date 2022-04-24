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
    @Binding var clothing: Clothing
    
    init(CC: ClosetController, selectedTab: Binding<Int>, clothing: Binding<Clothing>, selected: Binding<Bool>) {
        self.CC = CC
        self._selectedTab = selectedTab
        self._clothing = clothing
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
        .sheet(isPresented: $showPreview, onDismiss: {
            CC.saveCloset()
            selected = false
            selectedTab = 1
            clothing = Clothing()
        }) {
            PreviewView(CC: CC, clothing: clothing, selectedTab: $selectedTab, showPreview: $showPreview)
        }
    }
}
