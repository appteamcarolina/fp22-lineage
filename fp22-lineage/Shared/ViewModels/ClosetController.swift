//
//  ClosetController.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/17/22.
//

import Foundation

class ClosetController: ObservableObject {
     
    @Published var Closet = ["Hat":[Clothing](), "Jacket":[Clothing](), "Top":[Clothing](), "Bottoms":[Clothing](), "Shoes":[Clothing]()]
    
    init() {
        getCloset()
    }
    
    func getCloset() {
        guard
            let data = UserDefaults.standard.data(forKey: "Closet"),
            let savedCloset = try? JSONDecoder().decode([String: [Clothing]].self, from: data)
        else { return }
        self.Closet = savedCloset
    }
    
    func saveCloset() {
        if let encodedCloset = try? JSONEncoder().encode(Closet) {
            UserDefaults.standard.set(encodedCloset, forKey: "Closet")
        }
    }
    
    func clearCloset() {
        Closet = ["Hat":[Clothing](), "Jacket":[Clothing](), "Top":[Clothing](), "Bottoms":[Clothing](), "Shoes":[Clothing]()]
        saveCloset()
    }
    
    func getClothing(type: String, index: Int) -> Clothing {
        return Clothing(image: (Closet[type]?[index].image)!, mult: (Closet[type]?[index].mult)!, line: (Closet[type]?[index].line)!, type: (Closet[type]?[index].type)!, location: (Closet[type]?[index].location)!, photoChosen: true, choosingPhoto: true)
    }
    
    func addClothing(clothing: Clothing) {
        Closet[clothing.type]?.append(clothing)
        saveCloset()
    }
}
