//
//  NewPictureView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct NewPictureView: View {
    
    //@Binding var Closet: [[Clothing]]
    @StateObject var vm = NewPictureViewModel()
    
    var body: some View {
        ZStack {
            if !vm.changed {
                Image(uiImage: vm.clothing.image)
                    .resizable()
                    .scaledToFit()
                    .border(Color.black, width: 2)
            } else {
                Image(uiImage: vm.clothing.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(vm.clothing.border)
                    .border(Color.black, width: 2)
            }
            Canvas { context, size in
                var path = Path()
                path.addLines(vm.storedLine.points)
                context.stroke(path, with: .color(Color.black), lineWidth: vm.storedLine.lineWidth)
            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ value in
                vm.changeDrawing(value: value)
                })
            .onEnded({ value in
                vm.endDrawing()
            })
            )
            .frame(width: 420, height: 560)
            .border(Color.red, width: 2)
        }
    }
}

/*
struct NewPictureView_Previews: PreviewProvider {
    static var previews: some View {
        NewPictureView()
    }
}
 */
