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
    @State var photoChosen: Bool
    @State var choosingPhoto: Bool
    
    var border: Outline {
        get {
            return Outline(line: line, mult: mult)
        }
    }
    
    init(image: UIImage, mult: Double, line: Line, photoChosen: Bool) {
        self.image = image
        self.mult = mult
        self.line = line
        self.photoChosen = photoChosen
        self.choosingPhoto = false
    }
    
    private enum CodingKeys: String, CodingKey {
        case image, mult, line, photoChosen, choosingPhoto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mult = try container.decode(Double.self, forKey: .mult)
        line = try container.decode(Line.self, forKey: .line)
        photoChosen = try container.decode(Bool.self, forKey: .photoChosen)
        choosingPhoto = false
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
        try container.encode(photoChosen, forKey: .photoChosen)
        try container.encode(choosingPhoto, forKey: .choosingPhoto)
        let imageData = self.image.jpegData(compressionQuality: 0.1)
        try container.encode(imageData, forKey: .image)
    }
}
