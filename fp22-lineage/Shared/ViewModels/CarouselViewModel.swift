//
//  CarouselViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var Closet = [Clothing]()
    @Published var shirtIndex: Int = 0
    @Published var shirts = [Clothing]()
    
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
}
