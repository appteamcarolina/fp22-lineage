//
//  CarouselViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation

class CarouselViewModel: ObservableObject {
    
    @Published var topIndex: Int = 0
    
    func changeTopIndex(val: Int, len: Int) {
        if len > 0 {
            if topIndex + val < 0 {
                topIndex = len-abs(val)
            } else {
                topIndex = (topIndex + val)%len
            }
        }
    }
    func resetTopIndex() {
        topIndex = 0
    }
}
