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
    
    init() {
        getCloset()
        getIndexes()
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
    
    func getIndexes() {
        do {
            if let decodedHatIndex = UserDefaults.standard.data(forKey: "hatIndex") {
                let decodedHatIndex = try JSONDecoder().decode(Int.self, from: decodedHatIndex)
                self.hatIndex = decodedHatIndex
            }
            if let decodedJacketIndex = UserDefaults.standard.data(forKey: "jacketIndex") {
                let decodedJacketIndex = try JSONDecoder().decode(Int.self, from: decodedJacketIndex)
                self.jacketIndex = decodedJacketIndex
            }
            if let decodedTopIndex = UserDefaults.standard.data(forKey: "topIndex") {
                let decodedTopIndex = try JSONDecoder().decode(Int.self, from: decodedTopIndex)
                self.topIndex = decodedTopIndex
            }
            if let decodedBottomsIndex = UserDefaults.standard.data(forKey: "bottomsIndex") {
                let decodedBottomsIndex = try JSONDecoder().decode(Int.self, from: decodedBottomsIndex)
                self.bottomsIndex = decodedBottomsIndex
            }
            if let decodedShoesIndex = UserDefaults.standard.data(forKey: "shoesIndex") {
                let decodedShoesIndex = try JSONDecoder().decode(Int.self, from: decodedShoesIndex)
                self.shoesIndex = decodedShoesIndex
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
    
    func saveIndexes() {
        do {
            let encodedHatIndex = try JSONEncoder().encode(hatIndex)
            UserDefaults.standard.set(encodedHatIndex, forKey: "hatIndex")
            let encodedJacketIndex = try JSONEncoder().encode(jacketIndex)
            UserDefaults.standard.set(encodedJacketIndex, forKey: "jacketIndex")
            let encodedBottomsIndex = try JSONEncoder().encode(bottomsIndex)
            UserDefaults.standard.set(encodedBottomsIndex, forKey: "bottomsIndex")
            let encodedTopIndex = try JSONEncoder().encode(topIndex)
            UserDefaults.standard.set(encodedTopIndex, forKey: "topIndex")
            let encodedShoesIndex = try JSONEncoder().encode(shoesIndex)
            UserDefaults.standard.set(encodedShoesIndex, forKey: "shoesIndex")
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
        reset(type: "Hats")
        reset(type: "Jackets")
        reset(type: "Tops")
        reset(type: "Bottoms")
        reset(type: "Shoes")
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
        reset(type: type)
        saveCloset()
    }
    
    func reset(type: String) {
        switch type {
        case "Hats":
            hatIndex = 0
        case "Jackets":
            jacketIndex = 0
        case "Tops":
            topIndex = 0
        case "Bottoms":
            bottomsIndex = 0
        case "Shoes":
            shoesIndex = 0
        default:
            return
        }
        saveIndexes()
    }
    
    func changeHatIndex(val: Int, len: Int) {
        if len > 0 {
            if hatIndex + val < 0 {
                hatIndex = len-abs(val)
            } else {
                hatIndex = (hatIndex + val)%len
            }
        }
        saveIndexes()
    }
    
    func changeJacketIndex(val: Int, len: Int) {
        if len > 0 {
            if jacketIndex + val < 0 {
                jacketIndex = len-abs(val)
            } else {
                jacketIndex = (jacketIndex + val)%len
            }
        }
        saveIndexes()
    }
    
    func changeTopIndex(val: Int, len: Int) {
        if len > 0 {
            if topIndex + val < 0 {
                topIndex = len-abs(val)
            } else {
                topIndex = (topIndex + val)%len
            }
        }
        saveIndexes()
    }
    
    func changeBottomsIndex(val: Int, len: Int) {
        if len > 0 {
            if bottomsIndex + val < 0 {
                bottomsIndex = len-abs(val)
            } else {
                bottomsIndex = (bottomsIndex + val)%len
            }
        }
        saveIndexes()
    }
    
    func changeShoesIndex(val: Int, len: Int) {
        if len > 0 {
            if shoesIndex + val < 0 {
                shoesIndex = len-abs(val)
            } else {
                shoesIndex = (shoesIndex + val)%len
            }
        }
        saveIndexes()
    }
}
