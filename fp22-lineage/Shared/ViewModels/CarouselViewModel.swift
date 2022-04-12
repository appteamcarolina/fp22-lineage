//
//  CarouselViewModel.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var shirtIndex: Int = 0
    @Published var shirts = [Clothing]()
}
