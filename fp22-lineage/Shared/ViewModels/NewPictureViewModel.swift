//
//  NewPictureViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation
import SwiftUI

class NewPictureViewModel: ObservableObject {
    @Published var currentLine = Line()
    
    var counts: [Int] = [0]
    var currCount = 0
    
    func changeDrawing(value: DragGesture.Value) {
        let newPoint = value.location
        currCount+=1
        currentLine.points.append(newPoint)
    }
    
    func pauseDrawing() {
        counts.append(currCount)
        currCount = 0
    }
    
    func endDrawing(clothing: Clothing) -> Clothing {
        currentLine.points.append(currentLine.points[0])
        let clothingNew = clothing.updateLine(line: currentLine)
        return clothingNew
    }
    
    func resetDrawing(clothing: Clothing) -> Clothing {
        currentLine = Line(points: [])
        var defaultLine = Line()
        defaultLine.points.append(CGPoint(x:0,y:0))
        defaultLine.points.append(CGPoint(x:420,y:0))
        defaultLine.points.append(CGPoint(x:420,y:560))
        defaultLine.points.append(CGPoint(x:0,y:560))
        let clothingNew = clothing.updateLine(line: defaultLine)
        return clothingNew
    }
    
    func undo() {
        if counts.count == 1 {
            currentLine = Line()
        } else if counts.count == 2 {
            currentLine = Line()
            counts.removeLast()
        } else {
            currentLine.points = Array(currentLine.points[...(currentLine.points.count-counts[counts.count-1]-1)])
            counts.removeLast()
        }
    }
}
