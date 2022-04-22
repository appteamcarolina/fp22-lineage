//
//  Dummy.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/21/22.
//

import Foundation
import SwiftUI

struct Dummy: Codable {
    var image: UIImage
    var photoChosen: Bool
    var choosingPhoto: Bool
    
    init(image: UIImage = UIImage(imageLiteralResourceName: "dummy"), photoChosen: Bool = false, choosingPhoto: Bool = false) {
        self.image = image
        self.photoChosen = photoChosen
        self.choosingPhoto = choosingPhoto
    }
    
    private enum CodingKeys: String, CodingKey {
        case image, photoChosen, choosingPhoto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photoChosen = try container.decode(Bool.self, forKey: .photoChosen)
        choosingPhoto = false
        let imageData = try container.decode(Data.self, forKey: .image)
        guard let image = UIImage(data: imageData) else {
            self.image = UIImage(imageLiteralResourceName: "dummy")
            return
        }
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(photoChosen, forKey: .photoChosen)
        try container.encode(choosingPhoto, forKey: .choosingPhoto)
        let imageData = self.image.jpegData(compressionQuality: 0.1)
        try container.encode(imageData, forKey: .image)
    }
    
    func updatePhoto() -> Dummy {
        return Dummy(photoChosen: true, choosingPhoto: true)
    }
}
