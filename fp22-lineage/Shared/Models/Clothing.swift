//
//  Clothing.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation
import SwiftUI

struct Clothing {
    @State var image: Image
    @State var mult: Double
    @State var border: Outline
    
    init(image: Image, mult: Double, line: Line) {
        self.image = image
        self.mult = mult
        self.border = Outline(line: line, mult: mult)
    }
}
