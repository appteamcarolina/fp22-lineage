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
    @Published var changed = false
    @Published var clothing = Clothing(image: UIImage(imageLiteralResourceName: "shirt"), mult: 1, line: Line(), photoChosen: false)
    init(CC: ClosetController) {
        self.CC = CC
    }
    
    func changeDrawing(value: DragGesture.Value) {
        let newPoint = value.location
        currentLine.points.append(newPoint)
        storedLine = currentLine
    }
    
    func endDrawing() {
        currentLine.points.append(currentLine.points[0])
        storedLine = currentLine
        currentLine = Line(points: [])
        changed = true
        clothing.line = storedLine
        CC.Closet.append(clothing)
        CC.saveCloset()
    }
    
    func setPhoto() {
        clothing.photoChosen = true
        clothing.choosingPhoto = true
    }
}
