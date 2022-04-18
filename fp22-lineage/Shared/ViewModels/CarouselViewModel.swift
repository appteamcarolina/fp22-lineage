//
//  CarouselViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var shirtIndex: Int = 0
    
    func changeShirtIndex(val: Int, len: Int) {
        if len > 0 {
            if shirtIndex + val < 0 {
                shirtIndex = len-abs(val)
            } else {
                shirtIndex = (shirtIndex + val)%len
            }
        }
    }
    func resetShirtIndex() {
        shirtIndex = 0
    }
}
