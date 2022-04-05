//
//  ContentView.swift
//  Shared
//
//  Created by Jackson Dowden on 4/2/22.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .black
    var lineWidth: Double = 2.0
}

struct Outline: Shape {
    @State var line: Line
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLines(line.points)
        }
    }
}

struct ContentView: View {
    
    @State var currentLine = Line()
    @State var storedLine = Line()
    @State var border = Outline(line: Line())
    
    var body: some View {
        ZStack {
            
            Image("dog")
                .resizable()
                .scaledToFill()
                .clipShape(border)
            
            Canvas { context, size in
                var path = Path()
                path.addLines(storedLine.points)
                context.stroke(path, with: .color(storedLine.color), lineWidth: storedLine.lineWidth)
            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ value in
                let newPoint = value.location
                currentLine.points.append(newPoint)
                self.storedLine = currentLine
                })
            .onEnded({ value in
                currentLine.points.append(currentLine.points[0])
                storedLine = currentLine
                self.currentLine = Line(points: [])
                border = Outline(line: storedLine)
            })
            )
            
        }.frame(minWidth:400, minHeight: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
