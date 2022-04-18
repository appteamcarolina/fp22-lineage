//
//  ClosetController.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/17/22.
//

import Foundation

class ClosetController: ObservableObject {
    
    @Published var Closet = [Clothing]()
    
    init() {
        getCloset()
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
    
    func clearCloset() {
        Closet = [Clothing]()
        saveCloset()
    }
    
    func getClothing(index: Int, mult: Double) -> Clothing {
        return Clothing(image: Closet[index].image, mult: mult, line: Closet[index].line, photoChosen: true)
    }
}
