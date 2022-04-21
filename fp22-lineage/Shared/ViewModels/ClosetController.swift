//
//  ClosetController.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/17/22.
//

import Foundation
import SwiftUI

class ClosetController: ObservableObject {
    
    @Published var Hats = [Clothing(mult: 0, type: "Hats")]
    @Published var Jackets = [Clothing(type: "Jackets")]
    @Published var Tops = [Clothing(type: "Tops")]
    @Published var Bottoms = [Clothing(type: "Bottoms")]
    @Published var Shoes = [Clothing(type: "Shoes")]
    
    @Published var hatIndex: Int = 0
    @Published var jacketIndex: Int = 0
    @Published var topIndex: Int = 0
    @Published var bottomsIndex: Int = 0
    @Published var shoesIndex: Int = 0
    
    
    func reset() {
        hatIndex = 0
        jacketIndex = 0
        topIndex = 0
        bottomsIndex = 0
        shoesIndex = 0
    }
    
    func changeHatIndex(val: Int, len: Int) {
        if len > 0 {
            if hatIndex + val < 0 {
                hatIndex = len-abs(val)
            } else {
                hatIndex = (hatIndex + val)%len
            }
        }
    }
    
    func changeJacketIndex(val: Int, len: Int) {
        if len > 0 {
            if jacketIndex + val < 0 {
                jacketIndex = len-abs(val)
            } else {
                jacketIndex = (jacketIndex + val)%len
            }
        }
    }
    
    func changeTopIndex(val: Int, len: Int) {
        if len > 0 {
            if topIndex + val < 0 {
                topIndex = len-abs(val)
            } else {
                topIndex = (topIndex + val)%len
            }
        }
    }
    
    func changeBottomsIndex(val: Int, len: Int) {
        if len > 0 {
            if bottomsIndex + val < 0 {
                bottomsIndex = len-abs(val)
            } else {
                bottomsIndex = (bottomsIndex + val)%len
            }
        }
    }
    
    func changeShoesIndex(val: Int, len: Int) {
        if len > 0 {
            if shoesIndex + val < 0 {
                shoesIndex = len-abs(val)
            } else {
                shoesIndex = (shoesIndex + val)%len
            }
        }
    }
    
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
        getCloset()
    }
    
    func clearCloset() {
        self.Hats = [Clothing(type: "Hats")]
        self.Jackets = [Clothing(type: "Jackets")]
        self.Tops = [Clothing(type: "Tops")]
        self.Bottoms = [Clothing(type: "Bottoms")]
        self.Shoes = [Clothing(type: "Shoes")]
        reset()
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
    
    func deleteClothing(clothing: Clothing) {
        let type = clothing.type
        switch type {
        case "Hats":
            if let index = Hats.firstIndex(where: { $0.id == clothing.id }) {
                Hats.remove(at: index)
            }
        case "Jackets":
            if let index = Jackets.firstIndex(where: { $0.id == clothing.id }) {
                Jackets.remove(at: index)
            }
        case "Tops":
            if let index = Tops.firstIndex(where: { $0.id == clothing.id }) {
                Tops.remove(at: index)
            }
        case "Bottoms":
            if let index = Bottoms.firstIndex(where: { $0.id == clothing.id }) {
                Bottoms.remove(at: index)
            }
        case "Shoes":
            if let index = Shoes.firstIndex(where: { $0.id == clothing.id }) {
                Shoes.remove(at: index)
            }
        default:
            return
        }
        reset()
        saveCloset()
    }
}
