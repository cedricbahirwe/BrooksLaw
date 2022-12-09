//
//  Point.swift
//  BrooksLaw
//
//  Created by Cédric Bahirwe on 09/12/2022.
//

import SwiftUI

struct Point: Identifiable {
    var id: String { position.debugDescription }

    let position: CGPoint

    let color: Color

    init(_ position: CGPoint, _ color: Color) {
        self.position = position
        self.color = color
    }
}
