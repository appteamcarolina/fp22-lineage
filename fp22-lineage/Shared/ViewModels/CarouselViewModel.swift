//
//  CarouselViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation

class CarouselViewModel: ObservableObject {
    
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
}
