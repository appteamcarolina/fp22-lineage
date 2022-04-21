//
//  ClosetController.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/17/22.
//

import Foundation

class ClosetController: ObservableObject {
     
    @Published var Hats = [Clothing(mult: 0, type: "Hats")]
    @Published var Jackets = [Clothing(type: "Jackets")]
    @Published var Tops = [Clothing(type: "Tops")]
    @Published var Bottoms = [Clothing(type: "Bottoms")]
    @Published var Shoes = [Clothing(type: "Shoes")]
    
    init() {
        getCloset()
    }
    
    func getCloset() {
        do {
            if let decodedHats = UserDefaults.standard.data(forKey: "Hats") {
                let decodedHats = try JSONDecoder().decode([Clothing].self, from: decodedHats)
                self.Hats = decodedHats
            }
            if let decodedJackets = UserDefaults.standard.data(forKey: "Jackets") {
                let decodedJackets = try JSONDecoder().decode([Clothing].self, from: decodedJackets)
                self.Jackets = decodedJackets
            }
            if let decodedTops = UserDefaults.standard.data(forKey: "Tops") {
                let decodedTops = try JSONDecoder().decode([Clothing].self, from: decodedTops)
                self.Tops = decodedTops
            }
            if let decodedBottoms = UserDefaults.standard.data(forKey: "Bottoms") {
                let decodedBottoms = try JSONDecoder().decode([Clothing].self, from: decodedBottoms)
                self.Bottoms = decodedBottoms
            }
            if let decodedShoes = UserDefaults.standard.data(forKey: "Shoes") {
                let decodedShoes = try JSONDecoder().decode([Clothing].self, from: decodedShoes)
                self.Shoes = decodedShoes
            }

        } catch {
            print(error)
        }
    }
    
    func saveCloset() {
        do {
            let encodedHats = try JSONEncoder().encode(Hats)
            UserDefaults.standard.set(encodedHats, forKey: "Hats")
            let encodedJackets = try JSONEncoder().encode(Jackets)
            UserDefaults.standard.set(encodedJackets, forKey: "Jackets")
            let encodedTops = try JSONEncoder().encode(Tops)
            UserDefaults.standard.set(encodedTops, forKey: "Tops")
            let encodedBottoms = try JSONEncoder().encode(Bottoms)
            UserDefaults.standard.set(encodedBottoms, forKey: "Bottoms")
            let encodedShoes = try JSONEncoder().encode(Shoes)
            UserDefaults.standard.set(encodedShoes, forKey: "Shoes")
        } catch {
            print(error)
        }
    }
    
    func clearCloset() {
        self.Hats = [Clothing(type: "Hats")]
        self.Jackets = [Clothing(type: "Jackets")]
        self.Tops = [Clothing(type: "Tops")]
        self.Bottoms = [Clothing(type: "Bottoms")]
        self.Shoes = [Clothing(type: "Shoes")]
        saveCloset()
    }
    
    func getClothing(type: String, index: Int) -> Clothing {
        switch type {
        case "Hats":
            return Hats[index]
        case "Jackets":
            return Jackets[index]
        case "Tops":
            return Tops[index]
        case "Bottoms":
            return Bottoms[index]
        case "Shoes":
            return Shoes[index]
        default:
            return Clothing()
        }
    }
    
    func addClothing(clothing: Clothing) {
        let type = clothing.type
        switch type {
        case "Hats":
            Hats.append(clothing)
        case "Jackets":
            Jackets.append(clothing)
        case "Tops":
            Tops.append(clothing)
        case "Bottoms":
            Bottoms.append(clothing)
        case "Shoes":
            Shoes.append(clothing)
        default:
            return
        }
        saveCloset()
    }
}
