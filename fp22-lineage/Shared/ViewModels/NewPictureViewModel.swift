//
//  NewPictureViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation
import SwiftUI

class NewPictureViewModel: ObservableObject {
    @ObservedObject var CC: ClosetController
    @Published var currentLine = Line()
    @Published var storedLine = Line()
    
    init(CC: ClosetController) {
        self.CC = CC
    }
    
    func changeDrawing(value: DragGesture.Value) {
        let newPoint = value.location
        currentLine.points.append(newPoint)
        storedLine = currentLine
    }
    
    func endDrawing(clothing: Clothing) -> Clothing {
        currentLine.points.append(currentLine.points[0])
        storedLine = currentLine
        currentLine = Line(points: [])
        let clothingNew = clothing.updateLine(line: storedLine)
        return clothingNew
    }
    
    func resetDrawing(clothing: Clothing) -> Clothing {
        currentLine = Line(points: [])
        storedLine = currentLine
        var defaultLine = Line()
        defaultLine.points.append(CGPoint(x:0,y:0))
        defaultLine.points.append(CGPoint(x:420,y:0))
        defaultLine.points.append(CGPoint(x:420,y:560))
        defaultLine.points.append(CGPoint(x:0,y:560))
        let clothingNew = clothing.updateLine(line: defaultLine)
        return clothingNew
    }
}
