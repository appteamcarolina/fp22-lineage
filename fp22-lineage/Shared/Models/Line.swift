//
//  Line.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import Foundation
import SwiftUI

struct Line: Equatable, Hashable, Codable {
    var points: [CGPoint]
    var lineWidth: Double = 4.0
    
    init(points: [CGPoint] = [CGPoint]()) {
        self.points = points
    }
}
