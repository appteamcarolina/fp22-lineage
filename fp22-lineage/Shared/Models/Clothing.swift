//
//  Clothing.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation
import SwiftUI

struct Clothing: Codable {
    @State var image: UIImage
    @State var mult: Double
    @State var line: Line
    var border: Outline {
        get {
            return Outline(line: line, mult: mult)
        }
    }
    
    init(image: UIImage, mult: Double, line: Line) {
        self.image = image
        self.mult = mult
        self.line = line
    }
    
    private enum CodingKeys: String, CodingKey {
        case image, mult, line
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mult = try container.decode(Double.self, forKey: .mult)
        line = try container.decode(Line.self, forKey: .line)
        let imageData = try container.decode(Data.self, forKey: .image)
        guard let image = UIImage(data: imageData) else {
            self.image = UIImage(imageLiteralResourceName: "shirt")
            return
        }
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mult, forKey: .mult)
        try container.encode(line, forKey: .line)
        let imageData = self.image.jpegData(compressionQuality: 0.1)
        try container.encode(imageData, forKey: .image)
    }
}
