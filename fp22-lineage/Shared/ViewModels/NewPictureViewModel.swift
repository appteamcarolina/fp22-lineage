//
//  NewPictureViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation
import SwiftUI

class NewPictureViewModel: ObservableObject {
    @Published var Closet = [Clothing]()
    @Published var currentLine = Line()
    @Published var storedLine = Line()
    @Published var changed = false
    @Published var clothing = Clothing(image: UIImage(imageLiteralResourceName: "shirt"), mult: 1, line: Line())
    
    init() {
        getCloset()
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
        clothing = Clothing(image: UIImage(imageLiteralResourceName: "shirt"), mult: 1, line: storedLine)
        Closet.append(clothing)
        saveCloset()
    }
    
    func getCloset() {
        guard
            let data = UserDefaults.standard.data(forKey: "Closet"),
            let savedCloset = try? JSONDecoder().decode([Clothing].self, from: data)
        else { return }
        self.Closet = savedCloset
    }
    
    func saveCloset() {
        if let encodedCloset = try? JSONEncoder().encode(Closet) {
            UserDefaults.standard.set(encodedCloset, forKey: "Closet")
        }
    }
}
