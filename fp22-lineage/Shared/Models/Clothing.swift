//
//  Clothing.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/12/22.
//

import Foundation
import SwiftUI

struct Clothing: Codable {
    var image: UIImage
    var mult: Double
    var line: Line
    var type: String
    var location: CGPoint
    var photoChosen: Bool
    var choosingPhoto: Bool
    var border: Outline {
        get {
            return Outline(line: line, mult: mult)
        }
    }
    var width: Double {
        get {
            return mult * 420
        }
    }
    var height: Double {
        get {
            return mult * 560
        }
    }
    
    init(image: UIImage = UIImage(), mult: Double, line: Line, type: String = "", location: CGPoint = CGPoint(x: 210, y: 280), photoChosen: Bool = false, choosingPhoto: Bool = false) {
        self.image = image
        self.mult = mult
        self.line = line
        self.type = type
        self.location = location
        self.photoChosen = photoChosen
        self.choosingPhoto = choosingPhoto
    }
    
    private enum CodingKeys: String, CodingKey {
        case image, mult, line, type, location, photoChosen, choosingPhoto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mult = try container.decode(Double.self, forKey: .mult)
        line = try container.decode(Line.self, forKey: .line)
        type = try container.decode(String.self, forKey: .type)
        location = try container.decode(CGPoint.self, forKey: .location)
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
        try container.encode(type, forKey: .type)
        try container.encode(location, forKey: .location)
        try container.encode(photoChosen, forKey: .photoChosen)
        try container.encode(choosingPhoto, forKey: .choosingPhoto)
        let imageData = self.image.jpegData(compressionQuality: 0.1)
        try container.encode(imageData, forKey: .image)
    }
    
    func updatePhoto() -> Clothing {
        return Clothing(mult: mult, line: line, type: type, location: location, photoChosen: true, choosingPhoto: true)
    }
    
    func updateLine(line: Line) -> Clothing {
        return Clothing(image: image, mult: mult, line: line, type: type, location: location, photoChosen: photoChosen, choosingPhoto: choosingPhoto)
    }
    
    func updateMult(mult: Double) -> Clothing {
        return Clothing(image: image, mult: mult, line: line, type: type, location: location, photoChosen: photoChosen, choosingPhoto: choosingPhoto)
    }
    
    func updateType(type: String) -> Clothing {
        return Clothing(image: image, mult: mult, line: line, type: type, location: location, photoChosen: photoChosen, choosingPhoto: choosingPhoto)
    }
    
    func updateLocation(location: CGPoint) -> Clothing {
        return Clothing(image: image, mult: mult, line: line, type: type, location: location, photoChosen: photoChosen, choosingPhoto: choosingPhoto)
    }
}
