//
//  Outline.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import Foundation
import SwiftUI

struct Outline: Shape {
    @State var line: Line
    @State var mult: Double
    func path(in rect: CGRect) -> Path {
        Path { path in
            var x = mult * line.points[0].x
            var y = mult * line.points[0].y
            path.move(to: CGPoint(x: x, y: y))
            for point in line.points {
                x = mult * point.x
                y = mult * point.y
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
    }
}
